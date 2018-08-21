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
#      This file defines rules and targets common to all Apple
#      Xcode versions.
#

# Xcode has historically used and may continue to use GNU tools for
# its tool chain, so just source the GNU GCC common rules.

include target/tools/gnu/gcc/rules.mak
