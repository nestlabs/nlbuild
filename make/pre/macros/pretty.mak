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
#      This file defines make variables for performing coding style
#      formatting and checking.
#

PrettyVerb           = "Formatting"
PrettyCheckVerb      = "Checking"

PrettyVerbose        = echo "$(PrettyVerb) ($(PRETTY)) \"$${file}\"";
PrettyCheckVerbose   = echo "$(PrettyCheckVerb) ($(PRETTY_CHECK)) \"$${file}\"";

# PrettyPaths
#
# This defines the collection of files against which the PRETTY and
# PRETTY_CHECK profiles will be invoked for the 'pretty' and
# 'pretty-check' targets, respectively.
#
# This defaults to SOURCES and IncludeFiles and may be overriden or appended 
# to.

PrettyPaths      ?= $(SOURCES) $(IncludeFiles)

# PrettyMakefiles
#
# This defines the make files for which the recursive 'pretty' and
# 'pretty-check' targets will run against.
#
# This defaults to SubMakefiles and may be overridden or appended to.

PrettyMakefiles  ?= $(SubMakefiles)

