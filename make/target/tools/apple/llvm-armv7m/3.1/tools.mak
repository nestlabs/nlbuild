#
#    Copyright (c) 2010-2018 Nest Labs, Inc.
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
#    This file defines the access paths and basic flags for LLVM
#    version 3.1	
#

ToolRoot		= /usr/local/nestlabs/toolchains/llvm/3.1/armv7m

# We'll accept any 4.x or 4.x.x version of GCC with any build cruft
# trailing behind the version number.

LLVMVersRegExp		= 4\.\([[:digit:]]\{1,\}\.*\)\{1,2\}
LLVMBuildRegExp		= .*

# We'll accept any 2.* version of binutils with any build cruft
# trailing behind the version number.

BinutilsVersRegExp	= 2\.\([[:digit:]]\{1,\}[-.]*\)\{1,\}
BinutilsBuildRegExp	= .*

BinDir		= $(ToolRoot)/bin
IncDir		= $(ToolRoot)/include
LibDir		= $(ToolRoot)/lib

ToolBinDir		= $(BinDir)
ToolIncDir		= $(IncDir)
ToolLibDir		= $(LibDir)
ToolPrefix 		= armv7m-none-eabi-
# Include the LLVM common definitions.

include target/tools/$(ToolVendor)/$(ToolProduct)/tools.mak
