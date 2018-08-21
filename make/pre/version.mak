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
#      This file defines the default version number applied to the
#      software images created for this project tree.
#

#
# Software image version number fields. These are typically only
# applicable as defaults for an ad hoc build. Formal release builds
# will override these in the environment or on the command line. The
# format of the version is:
#
#   MAJOR.MINOR[.PATCH][TYPE[BUILD]][-EXTRA]
#
# and TYPE is one of:
#
#   d    development
#   a    alpha
#   b    beta
#   rc   release candidate
#

BuildVersionMajor		?= 1
BuildVersionMinor		?= 0
BuildVersionPatch		?=
BuildVersionType		?= d
BuildVersionNumber		?= 1
BuildVersionExtra		?=

#
# Build up the version number. This allows builders to override the
# 'BuildVersion' altogether with:
#
#   make BuildVersion="x.y.z"
#
# or on a component-by-component basis with:
#
#   make BuildVersionType="rc" BuildVersionNumber="43"
#

BuildVersion			?= $(BuildVersionMajor).$(BuildVersionMinor)$(if $(BuildVersionPatch),.$(BuildVersionPatch),)$(if $(BuildVersionType),$(BuildVersionType)$(BuildVersionNumber),)$(if $(BuildVersionExtra),-$(BuildVersionExtra))

