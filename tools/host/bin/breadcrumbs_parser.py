#!/usr/bin/env python

#
#    Copyright (c) 2017-2018 Nest Labs, Inc.
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


import sys
import pickle
import array
import os

# Find breadcrumbs library and import it. We first search
# in the current directory, in case this is a .tgz package
# created by Bamboo. Otherwise we expect it at a directory
# relative to our own in the repo-build repository.
cwd = os.path.dirname(os.path.abspath(__file__))
if os.path.isdir(cwd + '/breadcrumbs'):
    path = cwd + '/breadcrumbs'
elif os.path.isdir(cwd + '/../share/breadcrumbs'):
    path = cwd + '/../share/breadcrumbs'
else:
    print "\nError: \"breadcrumbs\" support files not found\n"
    exit(0)

sys.path.append(path)
from nestlabs.breadcrumbs.Event import *

class breadcrumbs_parser:
    def __init__(self, breadcrumbs_db, debug = False):
        self.debug = debug

        with open(breadcrumbs_db, "r") as dbfile:
            if debug:
                print "\n-----------------------------------------------"
                print "breadcrumbs-db path: " + os.path.abspath(breadcrumbs_db)
                print "-----------------------------------------------\n"
            self.all_hashes = pickle.load(dbfile)

    def get_data_with_size(self, array, start, size_in_bytes):
        result = 0
        for index in range(size_in_bytes):
            result += array[start+index] * 256**index
        return result

    def print_backtrace(self, data, size):
        depth = self.get_data_with_size(data, 0, 4)
        name_data = data[-4:]
        name = ""
        for x in name_data :
            if x == 0 :   # Null byte corrupts output when run as a subprocess
                break
            name += chr(x)

        depth = min(depth, 10)
        print ("\tthread = " + name + ", depth = %d" % depth)
        for x in range (0, depth):
            addr = self.get_data_with_size(data, 4*(x+1), 4)
            print "\t%2d: 0x%08x" % (x, addr)

    def process_breadcrumbs(self, flashOffset, stringArray):
        # convert stringArray into an int array where the values are base 16
        if self.debug: print "Processing stringArray [%s]" % stringArray
        dataArray = [int(i, 16) for i in stringArray]

        count = 0
        start = 0
        length = len(dataArray)

        while (count < length):
            start = count
            if self.debug: print "start at %x" % start
            bytes_left = length - start
            if bytes_left < 8:
                # too few elements to be a breadcrumb, which have
                # a mininimum size of 8 bytes.
                print "Skipped parsing last %d bytes, too small to be a breadcrumb\n" % bytes_left
                return count
            header = dataArray[start: start+8]
            hdata = self.get_data_with_size(header, 0, 4)
            uid = hdata >> 16
            id_string = '%04x' % uid

            if (id_string == "ffff"):
                # termination breadcrumb?
                return count

            buildVersion = (hdata & 0xffff)
            size = header[4]
            timeInMin = self.get_data_with_size(header, 5, 3)

            backtrace = False
            offset = 0
            data = dataArray[start+8: start+8+size]
            # params is a dict that is expected to have values
            # for breadcrumb descriptions. we parse the breadcrumb
            # to add entries to params, and they are referenced when
            # we call eval() on the description.
            params = dict()
            if self.debug: print "breadcrumb id: " + id_string
            if id_string in self.all_hashes :
                for (pname, psize) in self.all_hashes[id_string].param_sizes:
                    #lsize maybe 0,1,2,4
                    lsize = Event.get_param_size(int(psize))
                    if (lsize == 0):
                        # TODO: This script does not handle arrays generally.  If
                        # there is an array, it is assumed to be a backtrace.
                        if self.debug: print "get a blob %d bytes\n" % size
                        try:
                            print ("0x%04x: [%3d:%02d] " % (flashOffset,timeInMin/60,timeInMin%60) +
                                   "Build %d: " %buildVersion + self.all_hashes[id_string].name +
                                   ": " + eval(self.all_hashes[id_string].description))
                            self.print_backtrace(data, size)
                        except:
                            print ("0x%04x: ERROR: Could not parse backtrace!" % flashOffset)
                        backtrace = True
                        break
                    else:
                        if self.debug: print 'lsize = %d' % lsize
                        offset += lsize-1
                        offset = offset & (~(lsize-1))
                        try:
                            lval = self.get_data_with_size(data, offset, lsize)
                        except IndexError:
                            if self.debug: 'debug', data, offset, lsize, start, size
                            print ("Error parsing id_string: %s, param name: %s" % (id_string, pname))
                            lval = 0
                        if self.debug: print 'lval = %x' % lval
                        # add the value to the params dict
                        params[pname] = lval
                        offset += lsize

                if backtrace == 0 :
                    try:
                        print ("0x%04x: [%3d:%02d] " % (flashOffset,timeInMin/60,timeInMin%60) +
                               "Build %d: " %buildVersion + self.all_hashes[id_string].name +
                               ": " + eval(self.all_hashes[id_string].description))
                    except:
                        print ("0x%04x: ERROR: Could not parse %s!" % (flashOffset, self.all_hashes[id_string].name))
            else:
                print ("0x%04x: ERROR: breadcrumb id %s not in breadcrumb-db\n" % (flashOffset, id_string))
            count += size+8
            flashOffset += size+8

        return count

