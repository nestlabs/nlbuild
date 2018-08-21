#
#    Copyright (c) 2011-2018 Nest Labs, Inc.
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
#      This file defines the access paths and basic flags for Apple
#      Xcode 4.x.
#

ToolRoot		= /

# Unlike most GCC-based toolchains, Xcode uses GCC as a compiler
# frontend; however, the assembler, linker, etc. are an amalgamation
# of binutils and Apple-only tools. Consequently, version checking is
# quite a bit more complicated and patchwork.

GccVersRegExp		= 4\.2\.1
GccBuildRegExp		= 5658

BinutilsVersRegExp	= 
BinutilsBuildRegExp	= 

XcodeBinDir		= $(ToolRoot)usr/bin
XcodeIncDir		= $(ToolRoot)usr/include
XcodeLibDir		= $(ToolRoot)usr/lib

ToolBinDir		= $(XcodeBinDir)
ToolIncDir		= $(XcodeIncDir)
ToolLibDir		= $(XcodeLibDir)

# Include the Xcode common definitions

include target/tools/$(ToolVendor)/$(ToolProduct)/tools.mak
