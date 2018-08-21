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
#      (i.e. non-toolchain-specific) rules used in the project.
#

# Suffixes we define, use and support.

DependencySuffixes		= $(BaseDependSuffix) $(PatchedDependSuffix)
ObjectSuffixes			= $(StaticObjectSuffix) $(SharedObjectSuffix)
LibrarySuffixes			= $(ArchiveLibrarySuffix) $(SharedLibrarySuffix)
AssemblerSuffixes		= .S .s .s79
CSuffixes			= .c
CPlusPlusSuffixes		= .C .cc .cp .cpp .CPP .cxx .c++
ObjectiveCSuffixes		= .m
ObjectiveCPlusPlusSuffixes	= .mm
PreprocessedSuffixes		= $(addsuffix .i,$(CSuffixes) $(CPlusPlusSuffixes) $(ObjectiveCSuffixes) $(ObjectiveCPlusPlusSuffixes))

# Reset handled suffixes and set them to ones we want to handle.

.SUFFIXES:
.SUFFIXES: $(ArchiveSuffixes) $(AssemblerSuffixes) $(DependencySuffixes) $(CSuffixes) $(CPlusPlusSuffixes) $(ObjectiveCSuffixes) $(ObjectiveCPlusPlusSuffixes) $(ObjectSuffixes) $(PreprocessedSuffixes)

#
# Rule transformation definitions.
#
# Everything defined here is and must remain generic and tool-chain
# agnostic. Anything that relies on tool-chain specific behavior must
# be abstracted and referenced through a variable or macro call.
#

ArchiveVerb		= Archiving
AssembleVerb		= Assembling
PreprocessVerb		= Preprocessing
LinkVerb		= Linking
CompileVerb		= Compiling
DependVerb		= Depending
DisassembleVerb		= Disassembling
ExecuteVerb		= Executing
TranslateVerb		= Translating
SignVerb		= Signing
EditLogTableVerb	= Editing log table

PYTHONSHELL		:= python	
GEN_YCM_SCRIPT		:= ${BuildRoot}/build/scripts/ycm/gen_ycm_conf.py
SIGN_IMAGE_SCRIPT	:= $(BuildRoot)/build/scripts/elf_sign.py

define gen_ycm_files
$(Verbose) \
	if test -n "$(ENYCM)"; then \
		$(PYTHONSHELL) $(GEN_YCM_SCRIPT) $(call CanonicalizePath,$(<)) "-DROOT_MAKEFILE_DIR=$(CURDIR) $(CPPFLAGS) $(CXXFLAGS)"; \
	fi;
endef


# Command for converting an elf to a binary we can sign--has to remove the blank signature before signing
PREP_ELF_FOR_SIGNING_FLAGS += -R \"$(TargetApplicationSignatureSection)\"
tool-prepare-elf-for-signing="$(OBJCOPY) -I elf32-littlearm -O binary $(PREP_ELF_FOR_SIGNING_FLAGS)"

# Sign an image
define sign-image
$(Echo) "$(SignVerb) ($(LDName)) \"$(call ResultsPath,$@)\""
$(Verbose)$(PYTHONSHELL) $(SIGN_IMAGE_SCRIPT) $(@) $(AppSigningKeyURL) $(TargetApplicationSignatureSection) $(tool-prepare-elf-for-signing)
endef

# Transform a raw assembler file into an object file.

define assemble-asm
$(Echo) "$(AssembleVerb) ($(ASName)) \"$<\""
$(tool-assemble-asm)
endef

# Transform an assembler with C preprocessor file into a raw assembler file.

define preprocess-asm
$(Echo) "$(PreprocessVerb) ($(CPPName)) \"$<\""
$(tool-preprocess-asm)
endef

# Transform an assembler with C preprocessor file into an object file.

define preprocess-and-assemble-asm
$(Echo) "$(AssembleVerb) ($(ASName)) \"$<\""
$(tool-preprocess-and-assemble-asm)
endef

# Transform a C file into a preprocessed C file.

define preprocess-c
$(Echo) "$(PreprocessVerb) ($(CPPName)) \"$<\""
$(tool-preprocess-c)
endef

# Transform a C++ file into a preprocessed C++ file.

define preprocess-c++
$(Echo) "$(PreprocessVerb) ($(CPPName)) \"$<\""
$(tool-preprocess-c++)
endef

# Transform an Objective C file into a preprocessed Objective C file.

define preprocess-objective-c
$(Echo) "$(PreprocessVerb) ($(CPPName)) \"$<\""
$(tool-preprocess-objective-c)
endef

# Transform an Objective C++ file into a preprocessed Objective C++ file.

define preprocess-objective-c++
$(Echo) "$(PreprocessVerb) ($(CPPName)) \"$<\""
$(tool-preprocess-objective-c++)
endef

# While a bit of a misnomer, for human readability, these next four
# implicit rules are called "disassembling". This might be more
# accurately called "compiling"; however, that means something else to
# most. Perhaps "precompiling" or "preassembling" would be suitable
# alternatives.

# Transform a C file into a raw assembler file. 

define preprocess-and-compile-c
$(Echo) "$(DisassembleVerb) ($(CCName)) \"$<\""
$(tool-preprocess-and-compile-c)
endef

# Transform a C++ file into a raw assembler file. 

define preprocess-and-compile-c++
$(Echo) "$(DisassembleVerb) ($(CXXName)) \"$<\""
$(tool-preprocess-and-compile-c++)
endef

# Transform an Objective C file into a raw assembler file. 

define preprocess-and-compile-objective-c
$(Echo) "$(DisassembleVerb) ($(CCName)) \"$<\""
$(tool-preprocess-and-compile-objective-c)
endef

# Transform an Objective C++ file into a raw assembler file. 

define preprocess-and-compile-objective-c++
$(Echo) "$(DisassembleVerb) ($(CXXName)) \"$<\""
$(tool-preprocess-and-compile-objective-c++)
endef

# Transform a preprocessed C file into a raw assembler file.

define compile-c
$(Echo) "$(DisassembleVerb) ($(CCName)) \"$<\""
$(tool-compile-c)
endef

# Transform a preprocessed C++ file into a raw assembler file.

define compile-c++
$(Echo) "$(DisassembleVerb) ($(CXXName)) \"$<\""
$(tool-compile-c++)
endef

# Transform a preprocessed Objective C file into a raw assembler file.

define compile-objective-c
$(Echo) "$(DisassembleVerb) ($(CCName)) \"$<\""
$(tool-compile-objective-c)
endef

# Transform a preprocessed Objective C++ file into a raw assembler file.

define compile-objective-c++
$(Echo) "$(DisassembleVerb) ($(CXXName)) \"$<\""
$(tool-compile-objective-c++)
endef

# Transform a C file into an object file.

define preprocess-compile-and-assemble-c
$(Echo) "$(CompileVerb) ($(CCName)) \"$<\""
$(gen_ycm_files)
$(tool-preprocess-compile-and-assemble-c)
endef

# Transform a C++ file into an object file.

define preprocess-compile-and-assemble-c++
$(Echo) "$(CompileVerb) ($(CXXName)) \"$<\""
$(gen_ycm_files)
$(tool-preprocess-compile-and-assemble-c++)
endef

# Transform an Objective C file into an object file.

define preprocess-compile-and-assemble-objective-c
$(Echo) "$(CompileVerb) ($(CCName)) \"$<\""
$(gen_ycm_files)
$(tool-preprocess-compile-and-assemble-objective-c)
endef

# Transform an Objective C++ file into an object file.

define preprocess-compile-and-assemble-objective-c++
$(Echo) "$(CompileVerb) ($(CXXName)) \"$<\""
$(gen_ycm_files)
$(tool-preprocess-compile-and-assemble-objective-c++)
endef

# Transform a preprocessed C file into an object file.

define compile-and-assemble-c
$(Echo) "$(CompileVerb) ($(CCName)) \"$<\""
$(tool-compile-and-assemble-c)
endef

# Transform a preprocessed C++ file into an object file.

define compile-and-assemble-c++
$(Echo) "$(CompileVerb) ($(CXXName)) \"$<\""
$(tool-compile-and-assemble-c++)
endef

# Transform a preprocessed Objective C file into an object file.

define compile-and-assemble-objective-c
$(Echo) "$(CompileVerb) ($(CCName)) \"$<\""
$(tool-compile-and-assemble-objective-c)
endef

# Transform a preprocessed Objective C++ file into an object file.

define compile-and-assemble-objective-c++
$(Echo) "$(CompileVerb) ($(CXXName)) \"$<\""
$(tool-compile-and-assemble-objective-c++)
endef

# Transform an assembler with C preprocessor file into a dependency file.

define depend-asm
$(Echo) "$(DependVerb) ($(DEPENDName)) \"$<\""
$(tool-depend-asm)
endef

# Transform a C file into a dependency file.

define depend-c
$(Echo) "$(DependVerb) ($(DEPENDName)) \"$<\""
$(tool-depend-c)
endef

# Transform a C++ file into a dependency file.

define depend-c++
$(Echo) "$(DependVerb) ($(DEPENDName)) \"$<\""
$(tool-depend-c++)
endef

# Transform an Objective C file into a dependency file.

define depend-objective-c
$(Echo) "$(DependVerb) ($(DEPENDName)) \"$<\""
$(tool-depend-objective-c)
endef

# Transform an Objective C++ file into a dependency file.

define depend-objective-c++
$(Echo) "$(DependVerb) ($(DEPENDName)) \"$<\""
$(tool-depend-objective-c++)
endef

# XXX - Move this somewhere else

ResultsPath			= $(notdir $(1))

# Transform a set of objects into an archive library file.

define create-archive-library
$(Echo) "$(ArchiveVerb) ($(ARName)) \"$(call ResultsPath,$@)\""
$(tool-create-archive-library)
endef

# Transform a set of objects into a shared library file.

define link-shared-library
$(Echo) "$(LinkVerb) ($(LDName)) \"$(call ResultsPath,$@)\""
$(tool-link-shared-library)
endef

# Transform a set of objects and libraries into an executable program.

define link-program
$(Echo) "$(LinkVerb) ($(LDName)) \"$(call ResultsPath,$@)\""
$(tool-link-program)
endef

# Transform a set of objects and libraries into an image.

define link-image
$(Echo) "$(LinkVerb) ($(LDName)) \"$(call ResultsPath,$@)\""
$(tool-link-image)
endef

# Edit the string token table within the ELF file.

define tool-edit-log-table
$(Verbose)$(LOGTABLEEDITOR) $(LOGTABLEEDITORArgument) $(@)
endef

define edit-log-table
$(Echo) "$(EditLogTableVerb) ($(LOGTABLEEDITORName)) \"$(call ResultsPath,$@)\""
$(call tool-edit-log-table,$@)
endef

# Execute program, providing all required loader search paths.

define execute-program
$(Echo) "$(ExecuteVerb) \"$(call ResultsPath,$<)\""
$(Verbose)export $(LoaderSearchPath)=$(subst $(Space),:,$(dir $(LDLIBS) $(RESLIBS)))$(addprefix :,$($(LoaderSearchPath))) && $(<)
endef

# Translate an object file from one format into another.
#
# translate-image <input format> <output format>

# XXX - This needs to get abstracted and moved to a toolchain-specific
#       location

define tool-translate-image
$(Verbose)$(OBJCOPY) -I $(1) -O $(2) $(3) $(<) $(@)
endef

define translate-image
$(Echo) "$(TranslateVerb) ($(OBJCOPYName)) \"$(call ResultsPath,$@)\""
$(call tool-translate-image,$(1),$(2),$(3))
endef

define check-image-size
$(Verbose)imagefile=$(call ResultsPath,$@);\
  imagelimit=$($(call ResultsPath,$@)_MAXSIZE); \
  if [ "$${imagelimit}" != "" ]; then \
    echo "Checking ($(notdir $(SHELL))) \"$${imagefile}\""; \
    imagesize=`$(SIZE) $(@)`; \
    imageresid=`expr $${imagelimit} - $${imagesize}`; \
    if [ $${imageresid} -lt 0 ]; then \
      result="FAILED"; \
      imageresid=`expr 0 - $${imageresid}`; \
      message="$${imageresid} byte(s) over"; \
      status=1; \
    else \
      result="PASSED"; \
      imageutilization=`expr \( $${imagesize} \* 100 \) / $${imagelimit}`; \
      message="$${imageutilization}% utilized with $${imageresid} bytes available"; \
      status=0; \
    fi; \
    echo "$${result}: \"$${imagefile}\": $${imagesize}/$${imagelimit} ($${message})"; \
    exit $${status}; \
  fi
endef

#
# For the purposes of using it as a strongly-typed C compiler, the
# make file author can select on a make file-by-make file basis to
# treat and transform C source files as though they were C++ source
# files by defining 'TransformCAsCPlusPlus' to 'Yes'.
#

ifdef TransformCAsCPlusPlus
depend-c-or-c++							= $(depend-c++)
preprocess-c-or-c++						= $(preprocess-c++)
preprocess-objective-c-or-objective-c++				= $(preprocess-objective-c++)
preprocess-and-compile-c-or-c++					= $(preprocess-and-compile-c++)
preprocess-and-compile-objective-c-or-objective-c++		= $(preprocess-and-compile-objective-c++)
preprocess-compile-and-assemble-c-or-c++			= $(preprocess-compile-and-assemble-c++)
preprocess-compile-and-assemble-objective-c-or-objective-c++	= $(preprocess-compile-and-assemble-objective-c++)
compile-c-or-c++						= $(compile-c++)
compile-objective-c-or-objective-c++				= $(compile-objective-c++)
compile-and-assemble-c-or-c++					= $(compile-and-assemble-c++)
compile-and-assemble-objective-c-or-objective-c++		= $(compile-and-assemble-objective-c++)
else
depend-c-or-c++							= $(depend-c)
preprocess-c-or-c++						= $(preprocess-c)
preprocess-objective-c-or-objective-c++				= $(preprocess-objective-c)
preprocess-and-compile-c-or-c++					= $(preprocess-and-compile-c)
preprocess-and-compile-objective-c-or-objective-c++		= $(preprocess-and-compile-objective-c)
preprocess-compile-and-assemble-c-or-c++			= $(preprocess-compile-and-assemble-c)
preprocess-compile-and-assemble-objective-c-or-objective-c++	= $(preprocess-compile-and-assemble-objective-c)
compile-c-or-c++						= $(compile-c)
compile-objective-c-or-objective-c++				= $(compile-objective-c)
compile-and-assemble-c-or-c++					= $(compile-and-assemble-c)
compile-and-assemble-objective-c-or-objective-c++		= $(compile-and-assemble-objective-c)
endif # TransformCAsCPlusPlus

#
# Implicit rules
#

%.s: %.S
	$(preprocess-asm)

%.s: %.s79
	$(preprocess-asm)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.s | $(DependDirectory) $(BuildDirectory)
	$(assemble-asm)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.S | $(DependDirectory) $(BuildDirectory)
	$(preprocess-and-assemble-asm)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.s79 | $(DependDirectory) $(BuildDirectory)
	$(preprocess-and-assemble-asm)

%.c.i: %.c
	$(preprocess-c-or-c++)

%.m.i: %.m
	$(preprocess-objective-c-or-objective-c++)

%.cc.i: %.cc
	$(preprocess-c++)

%.cp.i: %.cp
	$(preprocess-c++)

%.cxx.i: %.cxx
	$(preprocess-c++)

%.cpp.i: %.cpp
	$(preprocess-c++)

%.CPP.i: %.CPP
	$(preprocess-c++)

%.c++.i: %.c++
	$(preprocess-c++)

%.C.i: %.C
	$(preprocess-c++)

%.mm.i: %.mm
	$(preprocess-objective-c++)

%.s: %.c
	$(preprocess-and-compile-c-or-c++)

%.s: %.m
	$(preprocess-and-compile-objective-c-or-objective-c++)

%.s: %.cc
	$(preprocess-and-compile-c++)

%.s: %.cp
	$(preprocess-and-compile-c++)

%.s: %.cxx
	$(preprocess-and-compile-c++)

%.s: %.cpp
	$(preprocess-and-compile-c++)

%.s: %.CPP
	$(preprocess-and-compile-c++)

%.s: %.c++
	$(preprocess-and-compile-c++)

%.s: %.C
	$(preprocess-and-compile-c++)

%.s: %.mm
	$(preprocess-and-compile-objective-c++)

%.s: %.c.i
	$(compile-c-or-c++)

%.s: %.m.i
	$(compile-objective-c-or-objective-c++)

%.s: %.cc.i
	$(compile-c++)

%.s: %.cp.i
	$(compile-c++)

%.s: %.cxx.i
	$(compile-c++)

%.s: %.cpp.i
	$(compile-c++)

%.s: %.CPP.i
	$(compile-c++)

%.s: %.c++.i
	$(compile-c++)

%.s: %.C.i
	$(compile-c++)

%.s: %.mm.i
	$(compile-objective-c++)

#
# Static Object Implicit Pattern Rules
#

ifeq ($(call IsYes,$(EnableShared)),Y)
$(call GenerateBuildPaths,%$(StaticObjectSuffix)): CCFLAGS += $(CCPICFlag)
$(call GenerateBuildPaths,%$(StaticObjectSuffix)): CXXFLAGS += $(CXXPICFlag)
endif

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.c.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c-or-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.m.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-objective-c-or-objective-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.cc.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.cp.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.cxx.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.cpp.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.CPP.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.c++.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.C.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.mm.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-objective-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.c | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c-or-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.m | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-objective-c-or-objective-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.cc | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.cp | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.cxx | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.cpp | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.CPP | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.c++ | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.C | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(StaticObjectSuffix)): %.mm | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-objective-c++)

#
# Shared Object Implicit Pattern Rules
#

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): CCFLAGS += $(CCPICFlag)
$(call GenerateBuildPaths,%$(SharedObjectSuffix)): CXXFLAGS += $(CXXPICFlag)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.c.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c-or-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.m.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-objective-c-or-objective-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.cc.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.cp.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.cxx.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.cpp.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.CPP.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.c++.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.C.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.mm.i | $(DependDirectory) $(BuildDirectory)
	$(compile-and-assemble-objective-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.c | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c-or-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.m | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-objective-c-or-objective-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.cc | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.cp | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.cxx | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.cpp | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.CPP | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.c++ | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.C | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-c++)

$(call GenerateBuildPaths,%$(SharedObjectSuffix)): %.mm | $(DependDirectory) $(BuildDirectory)
	$(preprocess-compile-and-assemble-objective-c++)

#
# Explicit targets
#

.PHONY: all recursive local-all
all: recursive local-all

.PHONY: prepare recursive local-prepare
prepare: recursive local-prepare

.PHONY: relinkimage recursive local-relinkimage
relinkimage: recursive local-relinkimage

.PHONY: cleanimage recursive local-cleanimage
cleanimage: recursive local-cleanimage

ifeq ($(TargetTuple),$(HostTuple))
.PHONY: execute recursive local-execute
execute: recursive local-execute
endif

# ARCHIVES and LIBRARIES are phony because they will never name a
# real, named target, but are rather the core of an archive or shared
# library name (e.g. lib<name>.a or lib<name>.so).

.PHONY: $(ARCHIVES) $(LIBRARIES)

# Define comprehensively what targets will be made by the 'local-all'
# rule and do so at this stage such that dependencies can be generated
# and specified as a goal for 'local-all'.

TARGETS	+= $(ARCHIVES) $(LIBRARIES) $(PROGRAMS) $(IMAGES)

# DEPEND_template <target>
#
# This instantiates a template for defining dependencies for the
# specified target. These dependencies are, in turn, accreted into the
# list of all dependencies for the current make file.

define DEPEND_template
$(1)_DEPENDS = $$(call GenerateBaseDependPaths,$$($(1)_SOURCES))
DEPENDS += $$($(1)_DEPENDS)
endef # DEPEND_template

$(foreach target,$(TARGETS),$(eval $(call DEPEND_template,$(target))))

define HEADER_source
$(foreach spec,$(1),$(firstword $(subst :, ,$(spec))))
endef # HEADER_source

define HEADER_result
$(foreach spec,$(1),$(call Slashify,$(ResultDirectory))$(lastword $(subst :, ,$(1))))
endef # HEADER_result

# HEADER_template <source>[:<result>]
#
# This instantiates a template for defining header dependency for the
# given header specification and updates the HEADERS variable.

define HEADER_template
$$(call HEADER_result,$(1)): $$(call HEADER_source,$(1)) | $(ResultDirectory)
HEADERS += $$(call HEADER_result,$(1))
endef # HEADER_template

$(foreach target,$(TARGETS),$(foreach header,$($(target)_HEADERS),$(eval $(call HEADER_template,$(header)))))

HeaderTargets = $(HEADERS)
$(HeaderTargets):
	$(install-result)

# Always include in the private 'local-all' target a command that'll
# always succeed to avoid "make[n]: Nothing to be done for `all'." 
# messages for make files that do not have an 'all' target with
# commands.

local-all: $(TARGETS) $(DEPENDS) $(HEADERS)
	$(Quiet)true

local-prepare: $(BuildDirectory) $(ResultDirectory) $(ResultIncDir) $(PrepareTargets) $(HEADERS)
	$(Quiet)true

local-cleanimage: 
	$(Quiet)rm -f $(ImageTargets)

local-relinkimage: $(IMAGES)
	$(Quiet)true

$(foreach target,$(PrepareTargets),$(eval $(call DEPEND_template,$(target))))

recursive: $(SubMakefiles)

.PHONY: force
force:

define nl-make-submakefile-target
$(Echo) $(@)
$(Echo) "Processing \"$(call GenerateBuildRootEllipsedPath,$(LOGCURDIR)/$@)\""
+$(Verbose)$(MAKE) $(JOBSFLAG) -C $(@D) -f $(@F) $(MFLAGS) $(MAKECMDGOALS)
endef # nl-make-submakefile-target

ifdef SubMakefiles
$(SubMakefiles): force
	$(nl-make-submakefile-target)
endif # SubMakefiles

# ASSIGNMENT_template <target> <what> <variable> <operation>
#
# This template instantiates a target assignment of:
#
# $(<target><what>): <variable> <operation> <target>_<variable>

define ASSIGNMENT_template
$($(1)$(2)): $(3) $(4) $($(1)_$(3))
endef # ASSIGNMENT_template

#
# Archive library target instantiation
#

ifdef ARCHIVES
ArchiveTargets = $(call GenerateArchiveLibraryPaths,$(ARCHIVES))

# ARCHIVE_template <target>
#
# This template instantiates a template for making the specified
# archive library target.

define ARCHIVE_template
SOURCES += $$($(1)_SOURCES)
$(1)_SOBJECTS += $$(call GenerateStaticObjectPaths,$$($(1)_SOURCES))
$$($(1)_SOBJECTS): | $$(call HEADER_result,$$($(1)_HEADERS))
$(1)_INCLUDES += $$(sort $$(dir $$($(1)_SOURCES)))
OBJECTS += $$($(1)_SOBJECTS)

$(1)_ARCHIVE := $(1)
$(1)_STARGET := $$(call GenerateArchiveLibraryPaths,$(1))
$(1): $$($(1)_STARGET)
$$($(1)_STARGET): $$($(1)_SOBJECTS)

$(1)_GENERATION := $$(call GenerateGenerationPaths,$(1))
GENERATIONS += $$($(1)_GENERATION)
$$($(1)_GENERATION): $$($(1)_SOBJECTS)
$$($(1)_STARGET): $$($(1)_GENERATION)

# These conditional assignments are per object.
$$(call ASSIGNMENT_template,$(1),_DEPENDS,CPPFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,INCLUDES,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,DEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,UNDEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_SOBJECTS,CPPFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_SOBJECTS,INCLUDES,+=)
$$(call ASSIGNMENT_template,$(1),_SOBJECTS,DEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_SOBJECTS,UNDEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_SOBJECTS,WARNINGS,+=)
endef # ARCHIVE_template

$(foreach archive,$(ARCHIVES),$(eval $(call ARCHIVE_template,$(archive))))

$(ArchiveTargets):
	$(create-archive-library)
endif # ARCHIVES

#
# Shared library target instantiation
#

ifdef LIBRARIES
LibraryTargets = $(call GenerateSharedLibraryPaths,$(LIBRARIES))

# LIBRARY_template <target>
#
# This template instantiates a template for making the specified
# shared library target.

define LIBRARY_template
SOURCES += $$($(1)_SOURCES)
$(1)_DOBJECTS += $$(call GenerateSharedObjectPaths,$$($(1)_SOURCES))
$$($(1)_DOBJECTS): | $$(call HEADER_result,$$($(1)_HEADERS))
$(1)_INCLUDES += $$(sort $$(dir $$($(1)_SOURCES)))
OBJECTS += $$($(1)_DOBJECTS)

$(1)_LIBRARY := $(1)
$(1)_DTARGET := $$(call GenerateSharedLibraryPaths,$(1))
$(1): $$($(1)_DTARGET)
$$($(1)_DTARGET): $$($(1)_DOBJECTS)
$$($(1)_DTARGET): $$($(1)_DEPLIBS)

$(1)_GENERATION := $$(call GenerateGenerationPaths,$(1))
GENERATIONS += $$($(1)_GENERATION)
$$($(1)_GENERATION): $$($(1)_DOBJECTS)
$$($(1)_DTARGET): $$($(1)_GENERATION)

# These conditional assignments are per object.
$$(call ASSIGNMENT_template,$(1),_DEPENDS,CPPFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,INCLUDES,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,DEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,UNDEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_DOBJECTS,CPPFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_DOBJECTS,INCLUDES,+=)
$$(call ASSIGNMENT_template,$(1),_DOBJECTS,DEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_DOBJECTS,UNDEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_DOBJECTS,WARNINGS,+=)

# These conditional assignments are per target.
$$(call ASSIGNMENT_template,$(1),_DTARGET,DEPLIBS,+=)
$$(call ASSIGNMENT_template,$(1),_DTARGET,LDLIBS,+=)
$$(call ASSIGNMENT_template,$(1),_DTARGET,RESLIBS,+=)
endef # LIBRARY_template

$(foreach library,$(LIBRARIES),$(eval $(call LIBRARY_template,$(library))))

$(LibraryTargets):
	$(link-shared-library)
endif # LIBRARIES

#
# Program target instantiation
#

ifdef PROGRAMS
ProgramTargets = $(call GenerateProgramPaths,$(PROGRAMS))
ifeq ($(TargetTuple),$(HostTuple))
ExecuteTargets = $(addprefix execute-,$(PROGRAMS))
endif

# PROGRAM_template <target>
#
# This template instantiates a template for making the specified
# program target.

define PROGRAM_template
SOURCES += $$($(1)_SOURCES)
$(1)_POBJECTS += $$(call GenerateStaticObjectPaths,$$($(1)_SOURCES))
$$($(1)_POBJECTS): | $$(call HEADER_result,$$($(1)_HEADERS))
$(1)_INCLUDES += $$(sort $$(dir $$($(1)_SOURCES)))
OBJECTS += $$($(1)_POBJECTS)

$(1)_PROGRAM := $(1)
$(1)_PTARGET := $$(call GenerateProgramPaths,$(1))
$(1): $$($(1)_PTARGET)
$$($(1)_PTARGET): $$($(1)_POBJECTS)
$$($(1)_PTARGET): $$($(1)_DEPLIBS)

$(1)_GENERATION := $$(call GenerateGenerationPaths,$(1))
GENERATIONS += $$($(1)_GENERATION)
$$($(1)_GENERATION): $$($(1)_POBJECTS)
$$($(1)_PTARGET): $$($(1)_GENERATION)

ifeq ($(TargetTuple),$(HostTuple))
$(1)_ETARGET := $(addprefix execute-,$(1))
$$($(1)_ETARGET): $$($(1)_PTARGET)
endif

# These conditional assignments are per object.
$$(call ASSIGNMENT_template,$(1),_DEPENDS,CPPFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,INCLUDES,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,DEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,UNDEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_POBJECTS,CPPFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_POBJECTS,INCLUDES,+=)
$$(call ASSIGNMENT_template,$(1),_POBJECTS,DEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_POBJECTS,UNDEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_POBJECTS,WARNINGS,+=)

# These conditional assignments are per target.
$$(call ASSIGNMENT_template,$(1),_PTARGET,LDFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_PTARGET,DEPLIBS,+=)
$$(call ASSIGNMENT_template,$(1),_PTARGET,LDLIBS,+=)
$$(call ASSIGNMENT_template,$(1),_PTARGET,RESLIBS,+=)

ifeq ($(TargetTuple),$(HostTuple))
# These conditional assignments are per target.
$$(call ASSIGNMENT_template,$(1),_ETARGET,LDLIBS,+=)
$$(call ASSIGNMENT_template,$(1),_ETARGET,RESLIBS,+=)
endif

endef # PROGRAM_template

$(foreach program,$(PROGRAMS),$(eval $(call PROGRAM_template,$(program))))

$(ProgramTargets):
	$(link-program)

ifeq ($(TargetTuple),$(HostTuple))

.PHONY: local-execute $(ExecuteTargets)

local-execute: $(ExecuteTargets)

$(ExecuteTargets):
	$(execute-program)

endif

endif # PROGRAMS

#
# Image target instantiation
#
ifdef IMAGES
ImageTargets = $(call GenerateImagePaths,$(IMAGES))
ImageBinTargets = $(call GenerateImageBinPaths,$(IMAGES))
ImageSrecTargets = $(call GenerateImageSrecPaths,$(IMAGES))

#
# Products made by build which are not direct targets
#
ImageMapTargets = $(call GenerateImageMapPaths,$(IMAGES))

# IMAGE_template <target>
#
# This template instantiates a template for making the specified
# image target.

define IMAGE_template
SOURCES += $$($(1)_SOURCES)
$(1)_IOBJECTS += $$(call GenerateStaticObjectPaths,$$($(1)_SOURCES))
$$($(1)_IOBJECTS): | $$(call HEADER_result,$$($(1)_HEADERS))
$(1)_INCLUDES += $$(sort $$(dir $$($(1)_SOURCES)))
OBJECTS += $$($(1)_IOBJECTS)
LDFLAGS += $$(ForceLinkVectorsCommand)

$(1)_SCATTER ?= $(call GenerateBuildPaths,$(1)$(LinkerDescriptorSuffix))
$(1)_MAPFILE ?= $(call GenerateResultPaths,,$(1)$(ImageMapSuffix))
$(1)_BINFILE ?= $(call GenerateResultPaths,,$(1)$(ImageBinSuffix))
$(1)_SRECFILE ?= $(call GenerateResultPaths,,$(1)$(ImageSrecSuffix))
$(1)_IMAGE := $(1)
$(1)_ITARGET := $$(call GenerateImagePaths,$(1)) $$(call GenerateImageBinPaths,$(1)) $$(call GenerateImageSrecPaths,$(1))

$(1): $$($(1)_ITARGET)
$$($(1)_ITARGET): $$($(1)_SCATTER)
$$($(1)_ITARGET): $$($(1)_IOBJECTS)
$$($(1)_ITARGET): $$($(1)_DEPLIBS)

$(1)_GENERATION := $$(call GenerateGenerationPaths,$(1))
GENERATIONS += $$($(1)_GENERATION)
$$($(1)_GENERATION): $$($(1)_IOBJECTS)
$$($(1)_ITARGET): $$($(1)_GENERATION)

$$($(1)_SCATTER): CPPFLAGS += -P -x c -I. -I./product/$(BuildProduct)
$$($(1)_SCATTER): $$(call GenerateBuildPaths,%.lkf): $$($(1)_SCATTER_TEMPLATE) | $(BuildDirectory) $(DependDirectory)
	$$(preprocess-c-or-c++)

SCATTERS += $$($(1)_SCATTER)
DEPENDS += $(call GenerateDependPaths,$(1).d)

# These conditional assignments are per object.
$$(call ASSIGNMENT_template,$(1),_DEPENDS,CPPFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,INCLUDES,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,DEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_DEPENDS,UNDEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_IOBJECTS,CPPFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_IOBJECTS,INCLUDES,+=)
$$(call ASSIGNMENT_template,$(1),_IOBJECTS,DEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_IOBJECTS,UNDEFINES,+=)
$$(call ASSIGNMENT_template,$(1),_IOBJECTS,WARNINGS,+=)

# These conditional assignments are per target.
$$(call ASSIGNMENT_template,$(1),_ITARGET,LDFLAGS,+=)
$$(call ASSIGNMENT_template,$(1),_ITARGET,DEPLIBS,+=)
$$(call ASSIGNMENT_template,$(1),_ITARGET,LDLIBS,+=)
$$(call ASSIGNMENT_template,$(1),_ITARGET,SCATTER,+=)
$$(call ASSIGNMENT_template,$(1),_ITARGET,MAPFILE,+=)
$$(call ASSIGNMENT_template,$(1),_ITARGET,BINFILE,+=)
$$(call ASSIGNMENT_template,$(1),_ITARGET,SRECFILE,+=)
endef # IMAGE_template

$(foreach image,$(IMAGES),$(eval $(call IMAGE_template,$(image))))

ifeq ($(UseLogTokenization),1)
$(ImageTargets) $(ImageMapTargets):
	$(link-image)
	$(call edit-log-table)
	$(if $(and $(call IsYes,$(SIGN_IMAGE)),$(AppSigningKeyURL)),$(sign-image))
else
$(ImageTargets) $(ImageMapTargets):
	$(link-image)
	$(if $(and $(call IsYes,$(SIGN_IMAGE)),$(AppSigningKeyURL)),$(sign-image))
endif

$(ImageBinTargets): $(ImageTargets)
	$(call translate-image,elf32-littlearm,binary,)
ifneq ($(ClangStaticAnalysis),1)
ifneq ($(UseLLVM),1)
	$(call check-image-size)
endif
endif

$(ImageSrecTargets): $(ImageTargets)
	$(call translate-image,elf32-littlearm,srec,--srec-forceS3)

endif # IMAGES

BaseDependPaths		= $(call GenerateBaseDependNames,$(DEPENDS))

DependPaths		= $(BaseDependPaths)

BuildPaths		+= $(OBJECTS)
BuildPaths              += $(SCATTERS)
BuildPaths		+= $(GENERATIONS)

ResultPaths		+= $(ArchiveTargets) $(LibraryTargets) $(ProgramTargets) $(ImageTargets) $(ImageMapTargets) $(ImageBinTargets) $(ImageSrecTargets) $(HeaderTargets)

# These are what post.mak will rely upon to include in all makefiles
# that include post.mak.

Dependencies		= $(BaseDependPaths)

#
# Check targets (checking build sanity, tool versions, environment
# configuration, etc.)
#

.PHONY: check check-local check-recursive
check:: check-local check-recursive

check-local: check-tools

check-recursive:

#
# Macro for checking tool versions
#

ifndef NoCheckToolVersions

define check-tool-version
	$(Echo) -n "Checking $(ToolDescription) version..."
	$(Verbose)version=`$(ToolPath) $(ToolVersionArgs) 2>&1 | $(SED) -n -e $(ToolSedArgs)` ; \
	echo $$version; \
	echo $$version | grep -q $(ToolGrepArgs); \
	if [ $$? -ne 0 ]; then \
		echo "Unexpected version for \"$(ToolPath)\"!"; \
		false; \
	fi
endef # check-tool-version

else # NoCheckToolVersions

define check-tool-version
endef

endif # NoCheckToolVersions

check-tools: maybe-check-tools

.PHONY: maybe-check-tools
maybe-check-tools: maybe-check-make \
	maybe-check-assemblers \
	maybe-check-binutils \
	maybe-check-compilers \
	maybe-check-preprocessors

.PHONY: maybe-check-make
maybe-check-make: do-check-make

.PHONY: do-check-make
do-check-make: ToolPath=$(MAKE)
do-check-make: ToolVersionArgs="--version"
do-check-make: ToolDescription="make"
do-check-make: ToolSedArgs=$(MAKESedArgs)
do-check-make: ToolGrepArgs=$(MAKEGrepArgs)
do-check-make:
	$(check-tool-version)

#
# Directory targets
#

# The following rules are collapsed into one since they
# might all effectively be the same directory.

$(DependDirectory) $(BuildDirectory) $(ResultDirectory) $(ResultIncDir):
	$(create-directory)

# Since the timestamp on directories change every time a file is
# added, specify the parent directory of these paths as an order-only
# prerequisite.

$(DependPaths): | $(DependDirectory)

$(BuildPaths): | $(BuildDirectory)

$(ResultPaths): | $(ResultDirectory)

#
# Generation targets
#

$(GENERATIONS):
	$(call UpdateGenerationPath,$(@))

#
# Clean targets
#

CleanPaths	+= $(DependPaths) \
		   $(BuildPaths) \
		   $(ResultPaths)

.PHONY: clean
clean: recursive local-clean

local-clean:
	$(Echo) "Cleaning in \"$(call GenerateBuildRootEllipsedPath,$(LOGCURDIR))\""
	$(Verbose)$(RM) $(RMFLAGS) $(CleanPaths)
	$(Verbose)$(RM) $(RMFLAGS) *~ "#"* *.i

#
# DistClean targets
#

.PHONY: distclean
distclean: recursive local-distclean

#
.PHONY: local-distclean
local-distclean: clean
    # Delete empty subdirectories in $(DependDirectory), $(BuildDirectory), and $(ResultDirectory),
    # the directory itself and it's ancestors if they are empty.  Don't fail if any
    # of these fail (can happen when there are sub Makefiles in the same folder, which can
    # result in multiple attempts to rmdir a folder in parallel builds).
	$(Echo) "DistCleaning in \"$(call GenerateBuildRootEllipsedPath,$(LOGCURDIR))\""
	$(Verbose)$(RM) $(RMFLAGS) $(DistCleanPaths)
	$(call remove-empty-directory-and-ancestors, $(BuildDirectory))
	$(call remove-empty-directory-and-ancestors, $(DependDirectory))
	$(call remove-empty-directory-and-ancestors, $(ResultDirectory))

#
# Debugging Targets
#

.PHONY: print-%
print-%:
	$(Quiet)echo '$*=$($*)'
	$(Quiet)echo '....origin = $(origin $*)'
	$(Quiet)echo '....flavor = $(flavor $*)'
	$(Quiet)echo '.....value = $(value  $*)'
	$(Quiet)echo ''

# Specific variables to exclude from the output of "make printvars". These
# variables may include $(error ...) in their expansion, causing printvars to
# terminate early, or cause printvars to hang indefinitely.
#
# PackageVersion and UpdateBuildHeader cause printvars to hang because they attempt to
# $(shell cat ...) a variable with an empty expansion.
#
printvars-filter := \
	ErrorIfUndefined \
	PackageVersion \
	UpdateBuildHeader \

# Classes of variables, as described by $(origin ...), to exclude from the
# output of "make printvars".
#
printvars-origin-filter := \
	environment% \
	default \
	automatic \

.PHONY: printvars
printvars:
	$(Quiet)$(foreach V,$(sort $(.VARIABLES)), \
		$(if $(filter-out $(printvars-origin-filter),$(origin $V)), \
			$(info $V=$(if $(filter-out $(printvars-filter),$V),$($V)))\
			$(info ....origin = $(origin $V)) \
			$(info ....flavor = $(flavor $V)) \
			$(info .....value = $(value  $V)) \
			$(info ) \
	))

include post/rules/pretty.mak
include post/rules/tps.mak

include target/tools/$(ToolTuple)/rules.mak
