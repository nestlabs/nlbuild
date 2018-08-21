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
#      This file defines make macros common to all third-party software
#      make headers and files.
#

PackageLicenseFile		= $(if $(PackageName),$(PackageName).license,)
PackageURLFile			= $(if $(PackageName),$(PackageName).url,)
PackageVersionFile		= $(if $(PackageName),$(PackageName).version,)

PackageVersion			?= $(shell cat $(PackageVersionFile))

PackagePatchDir			= $(PackageName).patches
PackagePatchPaths		= $(sort $(wildcard $(PackagePatchDir)/*.patch*))

# if BuildSnapshotRoot is defined, populate PackageSnapshotDir based
# on either the latest git revision of the DevRoot
ifdef BuildSnapshotRoot
  ifneq ($(findstring /production/fw/,$(LOGCURDIR)),)
    DevRoot				= fw
  else ifneq ($(findstring production/sw/tps/,$(LOGCURDIR)),)
    DevRoot				= sw/tps
  endif
  ifndef SnapshotRev
  export SnapshotRev := $(shell git log -1 --pretty=%H $(BuildRoot)/$(DevRoot))
  endif
  PackageSnapshotDir := $(call Deslashify,$(BuildSnapshotRoot)/$(DevRoot)/$(SnapshotRev)/$(BuildConfig)/$(BuildProduct))
else
  PackageSnapshotDir := $(call Deslashify,$(LOGCURDIR)/snapshots/$(ConditionalBuildTuple))
endif

PackageSnapshotFile		:= $(PackageName)-snapshot.tar.bz2
PackageSnapshotPath		:= $(call Slashify,$(PackageSnapshotDir))$(PackageSnapshotFile)
PackageDefaultGoal		:= $(if $(BuildMode),$(call ToLower,$(BuildMode)),stage)

# expand-and-patch-package
#
define expand-and-patch-package
$(call expand-archive,$(PackageArchive),.)
$(call patch-directory,$(@),$(PackagePatchArgs),$(PackagePatchPaths))
$(Verbose)touch $(@)
endef
