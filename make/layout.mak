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
#      This file is the top-level make file for the project. It determines how
#      platform and product Makefiles must be organized with respect to the
#      $(BuildRoot) to be discovered.
#

include pre.mak

#
# Product Makefiles are identified in pre.mak (look for BuildProductMakefile).
# The product Makefile must define BuildProductMakefile, which contains the path
# to the top-level Makefile for that product.
#
ifdef BuildProductTopMakefile
SubMakefiles = $(BuildProductTopMakefile)
endif

$(call ErrorIfUndefined,SubMakefiles)

SubMakefiles +=	$(ImageGen)

# As the initial Makefile, the default prepare step will try to create a
# result directory of the form $(BuildRoot)/results/<build-triple>/$(LOGCURDIR), which winds
# up being $(BuildRoot)/results/<build-triple>/$(BuildRoot), which isn't very useful.
# Override LOGCURDIR to be empty so that the result directory that
# is created is $(BuildRoot)/results/<build-triple>/
LOGCURDIR=

include post.mak
