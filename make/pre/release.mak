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
#      This file defines common macros used for generating build
#      release metadata.

#
# "Extra" image label build information. This can be overridden for
# nightlies (e.g. BuildExtra="") or for other purposes. Otherwise, it
# defaults to user- and SCM-specific information.
#

# "Extra" information to use if BuildExtra is truly 'undefined' and
# not explicitly provided anywhere else.

ifndef BuildExtraGenerated
export BuildExtraGenerated		:= $(shell $(MKBUILDEXTRA) --build-version $(BuildVersion))
endif

IsVariable			= $(findstring $(2),$(origin $(1)))
UseIfNotEmpty			= $(if $(1),-$(1),)

ifndef BuildExtraLocal
export BuildExtraLocal			:= $(if $(call IsVariable,BuildExtra,undefined),$(call UseIfNotEmpty,$(BuildExtraGenerated)),$(call UseIfNotEmpty,$(BuildExtra)))
endif

# GenerateImageLabel <image name>
# 
# Generates a label useful for comparing between release versions that
# includes all of the build environment parameters such that two
# otherwise equivalent versions will still be different when produced
# for different products, configurations or SCM states.

ifneq ($(BuildConfig),release)
GenerateImageLabel		= $(1)-$(BuildVersion)-$(BuildProduct)-$(BuildConfig)$(BuildExtraLocal)
else
GenerateImageLabel		= $(1)-$(BuildVersion)-$(BuildProduct)$(BuildExtraLocal)
endif
