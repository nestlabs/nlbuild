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


import types

# DON'T CHANGE THESE
Param_pointer = 0
Param_uint8   = 1
Param_uint16  = 2
Param_uint32  = 3
Param_int8    = 4
Param_int16   = 5
Param_int32   = 6
Param_uint64  = 7
Param_int64   = 8

class Event:
    
    def __init__(self, name, params, description):
        self.name = name
        for p in params:
            assert(type(p)==types.TupleType)
            assert(len(p)==2)
            assert(type(p[0]==types.StringType))
            assert(type(p[1]==types.IntType))
        self.params = params
        self.description = description
    def get_name(self):
        return self.name
    def get_params(self):
        return self.params
    def get_description(self):
        return self.description
    @staticmethod
    def get_param_size(param_type):
        sizes = (0, 1, 2, 4, 1, 2, 4, 8, 8)
        if param_type < len(sizes):
            return sizes[param_type]
        return 0;
