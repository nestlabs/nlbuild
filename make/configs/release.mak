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
#      This file defines build-specific options for the "release" build
#      configuration.
#

#
#  First, include the common build definitions.
#

include configs/common.mak

OPTIMIZER = $(OptimizeSize) $(DebugFlag)
CCOPTFLAGS += $(OPTIMIZER)
CXXOPTFLAGS += $(OPTIMIZER)
DEFINES += \
	NDEBUG=1

ifeq ($(call IsYes,$(ForceOptimizeNone)),Y)
WARNINGS += $(call ToolDeassertWarningFlag,$(WarnUninitialized))
FORCEOPTIMIZER = $(OptimizeNone) $(DebugFlag)
CCOPTFLAGS += $(FORCEOPTIMIZER)
CXXOPTFLAGS += $(FORCEOPTIMIZER)
endif
