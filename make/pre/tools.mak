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
#      This file is the make header for all common
#      (i.e. non-toolchain-specific) tools used in the project.
#

ToolchainsDir	= /usr/local/nestlabs/toolchains

# Source the make header for the host tools

include host/tools.mak

# Before we can source the correct make header for the desired tool
# chain, we need to ensure that the correct tool chain tuple variables
# are set.

$(call ErrorIfUndefined,ToolVendor)
$(call ErrorIfUndefined,ToolProduct)
$(call ErrorIfUndefined,ToolVersion)

MakeToolTuple	= $(1)/$(2)/$(3)

ToolTuple	= $(call MakeToolTuple,$(ToolVendor),$(ToolProduct),$(ToolVersion))
ImageToolTuple  = $(call MakeToolTuple,$(ImageToolVendor),$(ImageToolProduct),$(ImageToolVersion))

MakeToolName	= $(join $(notdir $(1))," $(ToolTuple)")

# Source the make header for the target tools specified by the current
# ToolTuple.

# Copy the image tools information to separate variables.
# This is a bit of hack, but it's the best we can do without major code changes.
include target/tools/$(ImageToolTuple)/tools.mak
ImageToolBinDir         := $(ToolBinDir)
ImageToolIncDir         := $(ToolIncDir)
ImageToolLibDir         := $(ToolLibDir)
include target/tools/$(ToolTuple)/tools.mak

#
# Macros for checking make version
#
# At this point, we'll happily accept 3.81, 3.82, or releases of 4.0
# or later.
#

MAKESedVers	= [[:digit:]]\{1,\}\.[[:digit:]]\{1,\}
MAKESedRegExp   = ^.*\(GNU Make $(MAKESedVers)\).*$
MAKESedCommand  = "s/$(MAKESedRegExp)/\1/gp"
MAKESedArgs	= $(MAKESedCommand)

MAKEGrepRegExp	= ^.*\(GNU Make \(3\.8[12]\|4.[[:digit:]]*\)\).*$
MAKEGrepPattern	= "$(MAKEGrepRegExp)"
MAKEGrepArgs	= $(MAKEGrepPattern)
