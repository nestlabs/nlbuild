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


import md5

from nestlabs.breadcrumbs.Event import *

UID_BYTES = 2

def backslashify(aString):
    return aString.replace('\n', ' \\\n')

def applyIndent(aString, indent):
    return aString.replace('$', '%s' % (' '*(2*indent)))


class EventDescriptor:
    """A simple class to wrap around the event description"""
    def __init__(self, filename, name, param_sizes, description):
        self.filename = filename.strip('\n')
        self.name = name
        self.param_sizes = param_sizes
        self.description = description
        return None
    def __getstate__(self):
        return (self.filename, self.name, self.param_sizes, self.description)
    def __setstate__(self, a_dict):
        self.filename = a_dict[0]
        self.name = a_dict[1]
        self.param_sizes = a_dict[2]
        self.description = a_dict[3]
    def name(self):
        return self.name
    def param_sizes(self):
        return self.param_sizes
    def description(self):
        return self.description
    def cksum(self):
        stringToHash = '%s %s' % (self.name, self.name)
        cksumr = md5.new(stringToHash)
        return cksumr.hexdigest()[:UID_BYTES*2]
    def __str__(self):
        return "%s %s | %s" % (self.name, self.param_sizes, self.description)
    def get_param_list(self):
        retval = ''
        i = 0
        for s in range(len(self.param_sizes)):
            retval += 'arg%d, ' % i
            i += 1
        return retval[0:-2]
    def get_args(self):
        retval = ''
        i = 0
        for sz in self.param_sizes:
            retval += '$$$%s, arg%d,\n' % ( Event.get_param_size(sz[1]), i)
            i += 1
        return retval
    def get_verify_string(self):
        retval = ''
        i = 0
        for s in self.param_sizes:
            retval += ('$$nlCHECK(sizeof(arg%d) == %s);\n' % (i, Event.get_param_size(s[1])))
            i += 1
        return retval
    def get_macro(self, indent_val):
        indent1=' '*((indent_val)*2)
        indent2=' '*((indent_val + 1)*2)
        aString = """\
#define nlBREADCRUMBS_%s(%s)
$do{
$$nl_breadcrumbs((k%s << %d),
%s$$$-1);
$} while(0)""" % (self.name, self.get_param_list(), self.name, UID_BYTES*8, self.get_args())
        return applyIndent("%s\n\n" % backslashify(aString), 2)
