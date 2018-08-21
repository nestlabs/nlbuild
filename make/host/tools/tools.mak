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
#      This file is the make header for all common host (i.e. non-
#      target or -toolchain-specific) tools used in the project.
#

#
# General host build tools we expect to find in normal system
# locations (e.g. /bin, /usr/bin, /sbin, and /usr/sbin).
#

MKDIR			= mkdir
MKDIRFLAGS		= -p

#
# Use "rmdir -p --ignore-fail-on-non-empty" to remove non-empty directories
# and their ancestors
#

RMDIR			= rmdir
RMDIRFLAGS		= -p --ignore-fail-on-non-empty
ifeq ($(BuildVerbose),1)
RMDIRFLAGS		+= -v
endif

PATCH			= patch
PATCHFLAGS		= -s

RM			= rm
RMFLAGS			= -f
ifeq ($(BuildVerbose),1)
RMFLAGS			+= -v
endif

SED			= sed
SEDFLAGS		= 

ifndef CCACHE                   # Don't define more than once.
ifndef DisableCcache            # Opt-out from the command line.
export CCACHE := $(shell which ccache)
endif
endif

INSTALL             = /usr/bin/install
INSTALLFLAGS            = -C

#
# Script used for creating and updating build information.
#

MKBUILD			:= ${BuildRoot}/build/third_party/nuovations/mkbuild
MKBUILDFLAGS		= -p

#
# Script used for creating "extra" build information.
#

MKBUILDEXTRA		:= ${BuildRoot}/build/scripts/mkbuildextra
MKBUILDEXTRAFLAGS	= 

#
# Script used for creating and updating build generation numbers.
#

MKGENERATION		:= ${BuildRoot}/build/third_party/nuovations/mkgeneration
MKGENERATIONFLAGS	= 

OPENOCD			:= $(ToolchainsDir)/openocd/bin/openocd
OPENOCDSHARE		:= $(ToolchainsDir)/openocd/share/openocd

# Common macro used in target commands for creating a directory as
# the target goal.

define create-directory
$(Echo) "Creating \"$(call GenerateBuildRootEllipsedPath,$@)\""
$(Verbose)$(MKDIR) $(MKDIRFLAGS) $@
endef

# Common macro used in target distclean commands for removing all
# empty subdirectories of a directory, and then remove the directory
# itself and its ancestors if it is empty.

define remove-empty-directory-and-ancestors
-$(Verbose)if [ -d $(1) ]; then \
	if [ "$$(ls -A $(1))" ]; then \
		find $(1)/* -depth -type d -exec $(RMDIR) {} +; \
	fi; \
	$(RMDIR) $(RMDIRFLAGS) $(1); \
fi;
endef

# create-links <source directory> <target directory>
#
# Common macro to create a "link farm" from a source directory to the
# target directory.

define create-links
$(Echo) "Shadowing \"$(call GenerateBuildRootEllipsedPath,$(1))\""
$(Verbose)$(LNDIR) $(1)/. $(2)
endef

# Common macro used in target commands for copying a file as the
# target goal from the target dependency.

define copy-result
$(Echo) "Copying \"$(call GenerateBuildRootEllipsedPath,$@)\""
$(Verbose)cp -f "$(<)" "$(@)"
endef

# Common macro used in target commands for moving a file as the
# target goal from the target dependency.

define move-result
$(Echo) "Moving \"$(call GenerateBuildRootEllipsedPath,$@)\""
$(Verbose)mv -f "$(<)" "$(@)"
endef

# Common macro used in target commands for installing a file as the
# target goal from the target dependency. Any missing parent
# directories in the target result are created, differing from
# copy-result above in which parent directories MUST exist.
#
# This is conducted in a host-dependent fashion.

define install-result
$(Echo) "Installing \"$(call GenerateBuildRootEllipsedPath,$@)\""
$(host-install-result)
endef

# expand-archive <source archive> <destination directory>
#
define expand-archive
$(Echo) "Expanding \"$(1)\" to \"$(2)\""
$(Verbose)extension=`echo $(1) | awk -F . '{if (NF > 1) {print $$NF}}'`; \
if [ $$extension = "7z" ]; then \
        7zr x -yw"$(2)" "$(1)" > /dev/null; \
elif [ $$extension = "bz2" ]; then \
	tar -C "$(2)" --bzip2 -xf "$(1)"; \
elif [ $$extension = "gz" ]; then \
	tar -C "$(2)" --gzip -xf "$(1)"; \
elif [ $$extension = "tar" ]; then \
	tar -C "$(2)" -xf "$(1)"; \
elif [ $$extension = "xz" ]; then \
	tar -C "$(2)" --xz -xf "$(1)"; \
elif [ $$extension = "Z" ]; then \
	tar -C "$(2)" -Z -xf "$(1)"; \
elif [ $$extension = "zip" ]; then \
	unzip -d "$(2)" -qo "$(1)"; \
else \
	echo "Unrecognized archive extension \"$$extension\"!"; \
	false; \
fi
endef

# patch-directory <directory> <arguments> <patch file> ...
#
define patch-directory
$(Verbose)for patch in $(3); do \
	echo "Applying \"$$patch\" to \"$(1)\""; \
	extension=`echo $$patch | awk -F . '{if (NF > 1) {print $$NF}}'`; \
	if [ $$extension = "bz2" ]; then \
		uncompressor="bunzip2 -c"; \
	elif [ $$extension = "gz" ]; then \
		uncompressor="gunzip -c"; \
	elif [ $$extension = "xz" ]; then \
		uncompressor="xz -d -c"; \
	elif [ $$extension = "Z" ]; then \
		uncompressor="uncompress -c"; \
	elif [ $$extension = "zip" ]; then \
		uncompressor="unzip -p"; \
	else \
		uncompressor="cat"; \
	fi; \
	$$uncompressor $$patch | $(PATCH) $(PATCHFLAGS) $(2) -d "$(1)" || exit; \
done
endef

# UpdateBuildHeader <image name> <generation path> <tool>
#
# Scope: Public
#
# Creates or updates a build header containing information about a
# target build name, user, host, compiler / tool, date, time and
# generation.
#
define UpdateBuildHeader
$(Echo) "Checking ($(notdir $(MKBUILD))) \"$(@)\""
$(Verbose)$(MKBUILD) $(MKBUILDFLAGS)			        \
	-c "$(shell $(3) $(ToolVersionArgs) 2>&1 | head -n 1)"  \
	-g "$(shell cat $(2))"				        \
	-o "$(@)"					        \
	"$(call ToTitle,$(1))"
endef

# UpdateReleaseHeader <image name> <version> <label> <description> <locales> <regions>
#
# Scope: Public
#
# Creates or updates a build header containing information about a
# target build version, label, description, locales, regions.
#

define UpdateReleaseHeader
$(Echo) "Checking ($(notdir $(SHELL))) \"$(call GenerateBuildRootEllipsedPath,$(@))\""
$(Verbose)set -e;					\
prefix="$(subst -,_,$(call ToUpper,$(1)))";             \
descrip="$(subst ",,$(4))";             \
/usr/bin/printf "#define $${prefix}_BUILD_VERSION      \"$(2)\"\n#define $${prefix}_BUILD_LABEL        \"$(3)\"\n#define $${prefix}_BUILD_DESCRIPTION  \"$${descrip}\"\n#define $${prefix}_BUILD_LOCALES      \"$(5)\"\n#define $${prefix}_BUILD_REGIONS      \"$(6)\"\n#define $${prefix}_BUILD_CONFIG       \"$(7)\"\n" > "$(@).N";						\
if [ -r "$(@)" ]; then    				\
    if cmp -s    "$(@)"   "$(@).N" ; then		\
	rm -f    "$(@).N";				\
    else						\
	echo "Updating ($(notdir $(SHELL))) \"$(call GenerateBuildRootEllipsedPath,$(@))\"";	\
	mv -f    "$(@)"   "$(@).O";			\
	mv -f    "$(@).N" "$(@)";			\
	$(RM) -f "$(@).O";				\
    fi							\
else							\
    echo "Generating ($(notdir $(SHELL))) \"$(call GenerateBuildRootEllipsedPath,$(@))\"";	\
    mv -f        "$(@).N" "$(@)";			\
fi
endef

# UpdateGenerationPath <path>
#
# Scope: Private
# 
# Update the generation number associated with an archive, image,
# library, program or other target.
#
define UpdateGenerationPath
$(Echo) "Updating ($(notdir $(MKGENERATION))) \"$(1)\""
$(Verbose)$(MKGENERATION) $(MKGENERATIONFLAGS) "$(1)"
endef

# We have to bootstrap ourselves into the notion of a correct host
# tuple. We do this by using a known, project-local version of
# automake's config.guess.

ifndef HostTuple
export HostTuple := $(shell $(BuildRoot)/build/third_party/automake/config.guess)
endif

# Fail the build if this did not result in successfully setting HostTuple.

$(call ErrorIfUndefined,HostTuple)

ifndef HostOS
export HostOS := $(call ToLower,$(shell uname -s))
endif

$(call ErrorIfUndefined,HostOS)

# Now that we know the host tuple, we can set the location we expect
# to find known, project-local host exectuables, libraries and
# includes.

HostToolRoot		:= $(BuildRoot)/build/tools/host
HostBinDir		:= $(HostToolRoot)/$(HostTuple)/bin
HostSbinDir		:= $(HostToolRoot)/$(HostTuple)/sbin
HostLibDir		:= $(HostToolRoot)/$(HostTuple)/lib
HostIncDir		:= $(HostToolRoot)/include
HostDataDir		:= $(HostToolRoot)/share

include host/tools/$(HostOS).mak

include host/tools/perl.mak
include host/tools/module-init-tools.mak
