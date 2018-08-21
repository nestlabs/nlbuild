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
#      This file defines make macros for checking the presence or
#      definition of make variables.
#

# ReportIfUndefined <function> <variable>
#
# This macro checks to see if the specified make variable is defined
# and, if not, calls the specified make-controlling function.

ReportIfUndefined       = $(if $(value $(2)),,$(call $(1),The make variable "$(2)" is not defined!))

# WarnIfUndefined <variable>
#
# This macro checks to see if the specified make variable is defined
# and, if not, calls the make-controlling warning function.

WarnIfUndefined         = $(call ReportIfUndefined,warning,$(1))

# ErrorIfUndefined <variable>
#
# This macro checks to see if the specified make variable is defined
# and, if not, calls the make-controlling warning function.

ErrorIfUndefined        = $(call ReportIfUndefined,error,$(1))
