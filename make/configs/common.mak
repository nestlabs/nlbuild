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
#      This file defines common options for the all build
#      configurations.
#

WARNINGS = \
	$(call ToolAssertWarningFlag,$(WarnEnable)) \
	$(call ToolAssertWarningFlag,$(WarnAll)) \
	$(call ToolAssertWarningFlag,$(WarnCharIndices)) \
	$(call ToolAssertWarningFlag,$(WarnFormatStrings)) \
	$(call ToolAssertWarningFlag,$(WarnParentheses)) \
	$(call ToolAssertWarningFlag,$(WarnReturnType)) \
	$(call ToolAssertWarningFlag,$(WarnSequencePoint)) \
	$(call ToolAssertWarningFlag,$(WarnShadow)) \
	$(call ToolAssertWarningFlag,$(WarnUninitialized)) \
	$(call ToolAssertWarningFlag,$(WarnTypeLimits))	    \
	$(call ToolAssertWarningFlag,$(WarnUnused)) \

CCWARNINGS = \
	$(WARNINGS) \
	$(call ToolAssertWarningFlag,$(WarnImplicitDeclarations)) \
	$(call ToolAssertWarningFlag,$(WarnStrictProtos)) \
	$(call ToolAssertWarningFlag,$(WarnMissingProtos)) \

CXXWARNINGS	= $(WARNINGS)

DEFINES += \
	BUILD_CONFIG=\"$(BuildConfig)\" \
	BUILD_CONFIG_$(call ToUpper,$(BuildConfig)) \
	BUILD_PRODUCT=\"$(BuildProduct)\" \
	BUILD_PRODUCT_$(call ToUpper,$(BuildProduct)) \
	NLNETWORKMANAGER_HAVE_PROJECT_SPECIFIC_CONFIG=1

ifeq ($(call IsYes,$(ForceWarningsAreErrors)),Y)
WARNINGS += $(call ToolAssertWarningFlag,$(WarnWarningsAreErrors))
FORCEOPTIMIZER = $(OptimizeMore) $(DebugFlag)
CCOPTFLAGS += $(FORCEOPTIMIZER)
CXXOPTFLAGS += $(FORCEOPTIMIZER)
endif

#
#  Include toolchain-specific settings.
#

-include configs/$(ToolVendor)-$(ToolProduct)-$(ToolVersion).mak
