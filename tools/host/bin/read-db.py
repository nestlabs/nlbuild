#!/usr/bin/env python

#
#    Copyright (c) 2013-2018 Nest Labs, Inc.
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
import os
import re
import argparse
import breadcrumbs_parser

def parse_diags (srcfile):
    retval = [ ]

    # Parse the dump from a diags build with each byte on a separate line
    for line in srcfile.readlines():
        # Look for each line (ex: "[1:07:08.285] [APPL] 0xf2" or "0xf2")
        match = re.match("((.*?)APPL\] )?0x([a-fA-F0-9]{2})\s+$", line)
        if match:
            retval.append(match.group(3))

    return retval

# expect breadcrumbs-db to be in same directory as our script
cwd = os.path.dirname(os.path.abspath(__file__))
breadcrumbs_parser = breadcrumbs_parser.breadcrumbs_parser(cwd + "/breadcrumbs-db", False)

STDIN_ARG = '--'
parser = argparse.ArgumentParser(description='Breadcrumb Decoder Tool')
parser.add_argument('--diags', action='store_true',
help="Parse the input as ASCII output from diags shell")
parser.add_argument('infile', nargs="?", default=STDIN_ARG,
help='Dump file or "--" for stdin.  Default behavior ' +
     'expects binary data in a file or ASCII hex data ' +
     'via stdin.')
args = parser.parse_args()

if args.infile != STDIN_ARG:
    if args.diags:
        with open(args.infile) as dump_file:
            stringArray = parse_diags(dump_file)
    else:
        # Dump a binary file in an ASCII format
        stringArray = os.popen("hexdump -ve \'1/1 \"%.2x \"\' " + re.escape(args.infile)).read().rstrip().split(" ")
else:
    if args.diags:
        stringArray = parse_diags(sys.stdin)
    else:
        # Read single space delimited ("0A B2 54 ...") line with entire dump
        stringArray = sys.stdin.readline().rstrip().split(" ")

print "\n*****%d bytes received, start decoding the log*****\n" % len(stringArray)

bytes_processed = breadcrumbs_parser.process_breadcrumbs(0, stringArray)

print "\n*****%d bytes valid, finished decoding the log*****\n" % bytes_processed
