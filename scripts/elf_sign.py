#
#    Copyright (c) 2016-2018 Nest Labs, Inc.
#    All rights reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

#
#    Description:
#      This script takes an ELF file, converts it to its binary in-memory
#      representation, signs it (using either an online service or a
#      locally-stored key), and replaces the contents of the specified
#      ELF section with the generated signature.
#
#    Usage:
#      elf_sign.py <elfPath> <signingKey> <sectionName> <elf2binCmd>
#
#      elfPath     - Path to the ELF we want to sign
#      signingKey  - Key to use (either a service URL or a local key path)
#      sectionName - ELF section to replace with signature
#      elf2binCmd  - Command for converting ELF to in-memory binary representation
#

import sys, os, subprocess, tempfile, collections, hashlib, binascii, pyasn1, pyasn1.codec.ber.decoder, pycurl, StringIO

SIGNATURE_NONE = b'\x00'
SIGNATURE_ECDSA_SHA256_SECP224R1 = b'\x01'

# Dump integer to a C array, used for debugging only
def c_array(name, val):
    length = len(val)
    res = ""
    for i in range(0, length):
        if (i % 16) == 0:
            res = res + "        "
        res = res + "0x%02x, " % val[i]
        if ((i % 16) == 15) | (i == (length - 1)):
            res = res + "\n"
    res = "    uint8_t " + name + "[] = {\n" + res + "    };"
    print res

# Read a little endian value from an ELF file
def elf_read_le(buf, offset, n):
    val = 0
    for i in range(0, n):
        val = (val << 8) | ord(buf[offset + n - 1 - i])

    return val

# Replace the contents of an ELF section. Used to replace blank signature data with the actual signature.
# binutils objcopy has a new command '--update-section .sectionname=file', but is not yet available. This does the same thing.
def elf_update_section(elfPath, sectionName, sectionData):
    sectionTuple = collections.namedtuple("sectionTuple", "name_offset, name, offset, size")

    # Read in the original ELF
    elfSize = os.stat(elfPath).st_size
    elf = open(elfPath, "rb")
    output = elf.read()
    elf.close()

    # Do some sanity checking on the ELF file headers
    magic = output[0:4]
    assert magic == b'\x7fELF', 'Magic number does not match'
    ei_class = output[4]
    assert ei_class == b'\x01', 'Only 32-bit ELF files are supported'
    ei_data = output[5]
    assert ei_class == b'\x01', "Only LE ELF files are supported"
    ei_version = output[6]
    assert ei_version == b'\x01', "Only ELF version 1 is supported"
    e_shoff = elf_read_le(output, 0x20, 4)     # Start of section header table
    e_shentsize = elf_read_le(output, 0x2e, 2) # Size of a section header table entry
    e_shnum = elf_read_le(output, 0x30, 2)     # Number of entries in the section header table
    e_shstrndx = elf_read_le(output, 0x32, 2)  # Index of the section header table entry that contains the section names
    assert (e_shoff + (e_shnum * e_shentsize)) <= elfSize, "Section header runs past end of file"
    assert e_shstrndx <= e_shnum, "Section name index > number of sections"

    # Read in all the sections in the table
    sections = []
    for i in range(0, e_shnum):
        sh_name = elf_read_le(output, (e_shoff + (i * e_shentsize) + 0), 4)
        sh_offset = elf_read_le(output, (e_shoff + (i * e_shentsize) + 16), 4)
        sh_size = elf_read_le(output, (e_shoff + (i * e_shentsize) + 20), 4)
        assert (sh_offset + sh_size) <= elfSize, "Section data runs past end of file"
        s = sectionTuple(name_offset = sh_name, name = "", offset = sh_offset, size = sh_size)
        sections.append(s)

    # Lookup the section names
    for i in range(0, e_shnum):
        s = sectionTuple(name_offset = sections[i].name_offset, \
                         name = output[(sections[e_shstrndx].offset + sections[i].name_offset):].partition(b'\x00')[0], \
                         offset = sections[i].offset, \
                         size = sections[i].size)
        sections[i] = s

    # Find the section we want to update
    sectionIndex = -1
    for i in range(0, e_shnum):
        if sections[i].name == sectionName:
            sectionIndex = i

    assert sectionIndex >= 0, "Section %s not found in ELF" % sectionName
    assert len(sectionData) == sections[sectionIndex].size, "Size of signature data file (%d) doesn't match size of section (%d)" % (len(sectionData), sections[sectionIndex].size)

    # Replace the ELF section with the new content
    output = output[0:sections[sectionIndex].offset] + \
             sectionData + \
             output[(sections[sectionIndex].offset + sections[sectionIndex].size):]

    elf = open(elfPath, "wb")
    elf.write(output)
    elf.close();

# Dump an integer as a byte array, in the big endian format used by micro-ecc
def int_to_bytearray(val, length):
    res = bytearray(length)
    for i in range(0, length):
        res[length - (1 + i)] = (val & 0xff)
        val = (val & ~0xff) >> 8

    assert val == 0, "Dumped int to C array, but length %i not big enough" % length
    return res

def main(argv):
    elfPath = sys.argv[1]     # Path to the ELF we want to sign
    signingKey = sys.argv[2]  # Key to use (either a service URL or a local key path)
    sectionName = sys.argv[3] # ELF section to replace with signature
    elf2binCmd = sys.argv[4]  # Command for converting ELF to in-memory binary representation

    # Generate a tempfile that we can dump the binary to. Objdump cannot dump to a pipe.
    tempBinFile = tempfile.NamedTemporaryFile();
    elf2binCmdline = elf2binCmd + " " + elfPath + " " + tempBinFile.name

    if 'debug' in globals():
        print "Signing %s, section '%s' using %s" % (elfPath, sectionName, signingKey)
        print "Generating bin using '%s'" % elf2binCmdline

    # Generate the binary that we sign (the provided command removes the signature placeholder section)
    os.system(elf2binCmdline);

    # Compute the SHA-256 hash of the image we are signing
    h = open(tempBinFile.name)
    hash = binascii.hexlify(hashlib.sha256(h.read()).digest())
    h.close()

    # Dump out the length and hash of the signed image
    if 'debug' in globals():
        print "Signed length = %d bytes" % os.stat(tempBinFile.name).st_size
        print "Image SHA-256 = %s" % hash

    # If the signingKey looks like a URL, we do online signing; otherwise, use a locally stored key
    if signingKey.startswith('https://'):
        # Append the hash to the URL
        signingKey = signingKey + "&hash=" + hash

        if 'debug' in globals():
            print "Signing using remote service URL: %s" % signingKey

        # Get the auth parameter that should have been exported from the environment
        assert 'auth' in os.environ, "Signing service credentials 'auth' not exported from environment"

        # Use cURL to request signing by the service
        buffer = StringIO.StringIO()
        curl = pycurl.Curl()
        curl.setopt(pycurl.URL, signingKey)
        if 'allowSelfSignedTLSCerts' in globals():
            curl.setopt(pycurl.SSL_VERIFYPEER, False)
        curl.setopt(pycurl.FAILONERROR, True)
        curl.setopt(pycurl.WRITEDATA, buffer)
        curl.setopt(pycurl.HTTPAUTH, pycurl.HTTPAUTH_BASIC)
        curl.setopt(pycurl.USERPWD, os.environ['auth'])
        try:
            curl.perform()
        except pycurl.error as e:
            # Handle HTTP error return codes user the assert below, to make it easier to diagnose issues
            if e.args[0] != curl.E_HTTP_RETURNED_ERROR:
                raise e
        http_code = curl.getinfo(pycurl.HTTP_CODE)
        assert http_code == 200, "HTTP error %d returned by service" % http_code
        curl.close()
        signature = buffer.getvalue()
        assert len(signature) == (2 * 60), "Signature returned by service has wrong length (%d != %d)" % (len(signature), (2 * 60))

        if 'debug' in globals():
            print "Service returned signature: %s" % signature

        sig = bytearray(binascii.unhexlify(signature))
    else:
        if 'debug' in globals():
            print "Signing using locally stored key"

        # Sign the binary, currently using a local key and OpenSSL.
        process = subprocess.Popen(["openssl", "dgst", "-sha256", "-sign", signingKey, tempBinFile.name], stdout=subprocess.PIPE)
        stdout = process.communicate()[0]

        # Extract the signature values from the DER output
        res = pyasn1.codec.ber.decoder.decode(stdout)[0]
        assert len(res) == 2, "Expected 2 values in generated EC signature, got %d" % len(res)
        assert isinstance(res.getComponentByPosition(0), pyasn1.type.univ.Integer), "EC signature result values weren't integers"
        assert isinstance(res.getComponentByPosition(1), pyasn1.type.univ.Integer), "EC signature result values weren't integers"
        r = int(res.getComponentByPosition(0))
        s = int(res.getComponentByPosition(1))

        # Generate the signature block.
        # The size of this signature block needs to match the size of the signature
        # placeholder section that was set aside in the linker script.
        # The signature data (r,s) also needs to be 4-byte aligned.
        sig = SIGNATURE_ECDSA_SHA256_SECP224R1 + \
              b'\x00\x00\x00'                  + \
              int_to_bytearray(r, (224/8))     + \
              int_to_bytearray(s, (224/8))

        # Dump out the r,s values
        if 'debug' in globals():
            c_array("signature_r", int_to_bytearray(r, (224/8)))
            c_array("signature_s", int_to_bytearray(s, (224/8)))

    # Dump out the complete generated signature
    if 'debug' in globals():
        c_array("signature", sig)

    # Update the ELF section with the generated signature data
    elf_update_section(elfPath, sectionName, sig)

    tempBinFile.close()

if __name__ == "__main__":
    main(sys.argv[1:])

