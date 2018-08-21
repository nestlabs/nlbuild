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
#      This file defines access paths, environment variables and basic
#      flags for tools common to the built-in GNU Compiler Collection (GCC)
#      under OS X.
#

# Some common GCC-specific variables and macros

GccAssertFlag			= $(if $(2),$(1)$(2),)
GccDeassertFlag			= $(if $(2),$(1)no-$(2),)

GccWarningFlag			= -W
ToolAssertWarningFlag		= $(call GccAssertFlag,$(GccWarningFlag),$(1))
ToolDeassertWarningFlag		= $(call GccDeassertFlag,$(GccWarningFlag),$(1))

GccLanguageFlag			= -f
ToolAssertLanguageFlag		= $(call GccAssertFlag,$(GccLanguageFlag),$(1))
ToolDeassertLanguageFlag	= $(call GccDeassertFlag,$(GccLanguageFlag),$(1))

GccMachineFlag			= -m
ToolAssertMachineFlag		= $(call GccAssertFlag,$(GccMachineFlag),$(1))
ToolDeassertMachineFlag		= $(call GccDeassertFlag,$(GccMachineFlag),$(1))

GccOutputFlag			= -o
GccNoAssembleFlag		= -S
GccNoLinkFlag			= -c
GccInputFlag			= 
GccPICFlag			= $(call ToolAssertLanguageFlag,PIC)
GccCoverageFlag			= --coverage

# Debug variables

DebugFlag			= -g

# Profile variables

ProfileFlag			= -pg

# Optimizer variables

OptimizeNone			= -O0
OptimizeLeast			= -O1
OptimizeLess			= -O1
OptimizeMore			= -O2
OptimizeMost			= -O3
OptimizeSize			= -Os

# Language variables

LangForwardPropagation	        = forward-propagate
LangExceptionHandling		= exceptions
LangRuntimeTypeInformation	= rtti

# Warning variables

WarnEnable			=
WarnDisable			= -w
WarnAll				= all
WarnCharIndices			= no-char-subscripts
WarnFormatStrings		= format
WarnImplicitDeclarations	= implicit
WarnShadow			= shadow
WarnReturnType			= return-type
WarnStrictProtos		= strict-prototypes
WarnMissingProtos		= missing-prototypes
WarnNonVirtualDestructors	= non-virtual-dtor
WarnParentheses			= parentheses
WarnPointerMath			= pointer-arith
WarnReturnType			= return-type
WarnSequencePoint		= sequence-point
WarnUninitialized		= uninitialized
WarnUnused			= unused
WarnUnusedLabels		= unused-label
WarnUnusedParams		= unused-parameter
WarnUnusedValues		= unused-value
WarnUnusedVars			= unused-variable
WarnUnusedFunctions		= unused-function
WarnWritableStrings		= write-strings
WarnTypeLimits			= type-limits

# The archiver (librarian)

AR				:= $(ToolBinDir)/ar
ARName				= $(call MakeToolName,$(AR))
ARInputFlag			= 
AROutputFlag			= 
ARCreateFlag			= -c
ARReplaceFlag			= -r

ARFLAGS				= $(ARCreateFlag) $(ARReplaceFlag)

# The assembler

AS				:= $(ToolBinDir)/gcc
ASName				= $(call MakeToolName,$(AS))
ASInputFlag                     = $(GccInputFlag)
ASOutputFlag                    = $(GccOutputFlag)

ASFLAGS				+= $(ASOPTFLAGS) $(ASWARNINGS) $(GccNoLinkFlag)

# The C preprocessor

CPP				:= $(CCACHE) $(ToolBinDir)/cpp
CPPName				= $(call MakeToolName,$(CPP))
CPPDefineFlag			= -D
CPPUndefineFlag			= -U
CPPIncludeFlag			= -I
CPPInputFlag			= $(GccInputFlag)
CPPOutputFlag			= $(GccOutputFlag)
CPPDependFlags			= -MT "$@ $(call GenerateDependPaths,$*.d)" -MD -MP -MF "$(call GenerateDependPaths,$*.d)"

CPPFLAGS			= $(CPPOPTFLAGS) \
				  $(call ToolGenerateDefineArgument,$(DEFINES)) \
				  $(call ToolGenerateUndefineArgument,$(UNDEFINES)) \
				  $(call ToolGenerateIncludeArgument,$(INCLUDES)) \
			  	  $(if $(filter-out %.d,$@),$(CPPDependFlags))

# The C compiler

CC				:= $(CCACHE) $(ToolBinDir)/clang
CCName				= $(call MakeToolName,$(CC))
CCNoAssembleFlag		= $(GccNoAssembleFlag)
CCNoLinkFlag			= $(GccNoLinkFlag)
CCInputFlag			= $(GccInputFlag)
CCOutputFlag			= $(GccOutputFlag)
CCPICFlag			= $(GccPICFlag)
CCCoverageFlag			= $(GccCoverageFlag)

CCFLAGS				= $(CCOPTFLAGS) $(CCWARNINGS) $(CCCoverageFlag)

# The C++ compiler

CXX				:= $(CCACHE) $(ToolBinDir)/clang++
CXXName				= $(call MakeToolName,$(CXX))
CXXNoAssembleFlag		= $(GccNoAssembleFlag)
CXXNoLinkFlag			= $(GccNoLinkFlag)
CXXInputFlag			= $(GccInputFlag)
CXXOutputFlag			= $(GccOutputFlag)
CXXPICFlag			= $(GccPICFlag)
CXXCoverageFlag			= $(GccCoverageFlag)

CXXFLAGS			= $(CXXOPTFLAGS) $(CXXWARNINGS) $(CCCoverageFlag)

# The Objective C compiler flag

OBJCCLanguage			:= -x objective-c

# The Objective C++ compiler flag

OBJCXXLanguage			:= -x objective-c++

# The dependency generator

DEPEND				:= $(ToolBinDir)/cpp
DEPENDName			= $(call MakeToolName,$(DEPEND))
DEPENDInputFlag			=
DEPENDOutputFlag		= -o

DEPENDFLAGS			= -E -MT "$(call GenerateBuildPaths,$*.o) $@" -MM -MP -MF $@

# The linker

LD				= $(ToolBinDir)/$(if $(LinkAgainstCPlusPlus),g++,gcc)
LDName				= $(call MakeToolName,$(LD))
LDLibraryNameFlag		= -l
LDLibraryPathFlag		= -L
LDOutputFlag			= $(GccOutputFlag)
LDSharedFlag			= -shared
LDSharedNameFlag		= -Wl,-soname=
LDResolvePathFlag		= -Wl,-rpath-link,
LDExportDynamicSymbols          = -rdynamic
LDGCovFlag                      = -lprofile_rt

# The symbol lister

NM				:= $(ToolBinDir)/nm
NMName				= $(call MakeToolName,$(NM))

# The object copier

OBJCOPY				:= $(ToolBinDir)/objcopy
OBJCOPYName			= $(call MakeToolName,$(OBJCOPY))

# The library indexer

RANLIB				:= $(ToolBinDir)/ranlib
RANLIBName			= $(call MakeToolName,$(OBJCOPY))

# The symbol stripper

STRIP				:= $(ToolBinDir)/strip
STRIPName			= $(call MakeToolName,$(STRIP))

ToolGenerateArgument		= $(if $(2),$(addprefix $(1),$(2)))

ToolGenerateIncludeArgument	= $(call ToolGenerateArgument,$(CPPIncludeFlag),$(1))
ToolGenerateDefineArgument	= $(call ToolGenerateArgument,$(CPPDefineFlag),$(1))
ToolGenerateUndefineArgument	= $(call ToolGenerateArgument,$(CPPUndefineFlag),$(1))

ToolGenerateLibraryPathArgument	= $(call ToolGenerateArgument,$(LDLibraryPathFlag),$(1))
ToolGenerateLibraryNameArgument	= $(call ToolGenerateArgument,$(LDLibraryNameFlag),$(1))

ToolLibraryPathArgumentIsPath	= $(if $(call IsRelativePath,$(1)),$(call GenerateResultPaths,,$(dir $(1))),$(dir $(1)))
ToolLibraryPathArgumentIsNotPath	=

ToolLibraryPathArgumentHandler	= $(if $(call IsPath,$(1)),$(call ToolLibraryPathArgumentIsPath,$(1)),$(call ToolLibraryPathArgumentIsNotPath,$(1)))

# GenerateLibraryPathArgument <argument>
#
# This generates the library search path component of a link library
# as follows:
#
#   * Arguments that are relative paths (i.e. contain a directory
#     delimiter but no leading delimiter) generate an absolute search
#     path, relative to the current results directory.
#
#   * Arguments that are absolute paths (i.e. contain a directory
#     delimiter and a leading delimiter) are untouched and generate a
#     search path as is.
#
#   * Arguments that are not paths (i.e. contain no directory
#     delimiter) are assumed to be system libraries and generate no search
#     path.

GenerateLibraryPathArgument	= $(call ToolGenerateLibraryPathArgument,$(call ToolLibraryPathArgumentHandler,$(1)))

GenerateLibraryNameArgument	= $(call ToolGenerateLibraryNameArgument,$(notdir $(1)))
GenerateLibraryArgument		= $(call GenerateLibraryPathArgument,$(1)) $(call GenerateLibraryNameArgument,$(1))

GenerateLibraryArguments	= $(foreach library,$(1),$(call GenerateLibraryArgument,$(library)))

# GenerateResolvePathArgument <argument>
#
# This generates the library resolve search path of a dependent
# library. These are typically passed at the end of a link command for
# executable and shared library targets to resolve library
# dependencies not of the link target ITSELF but of the link target's
# shared libraries.
#
# Let's say that target foo depends on libbar.so and that libbar.so
# depends on liba.so and libb.so. Without specifying resolve paths,
# foo would need to link against lbar, la and lb. The first makes
# sense; however, the latter two would be surprising because, to the user
# of the 'bar' library, they are effectively hidden. Nonetheless, the
# linker still needs to know they exist and can be, eventually, resolved.
#
# So, there are two solutions to this problem. The first option, just
# specifies these "hidden" and "missing" libraries as link
# dependencies. However, as you travel "up" the library stack, you end
# up have an geometrically-increasing set of link libraries
# required. You depend on not only what you link against but
# everything they linked against and on down the dependency tree.
#
# The second option specifies these "hidden" and "missing" libraries
# as resolve dependencies without actually linking them. This keeps
# library requirements as you move "up" the library stack constant,
# that is you only depend on what you link against, not everything
# those libraries linked against.
#
# When cross-compiling, it is almost impossible to get rid of the need
# to be aware that these libraries are "missing"; however, by using
# resolve paths, the names can be resolved without having those
# "missing" libraries end up in the "NEEDED" section of the target.

GenerateResolvePathArgument	= $(call ToolGenerateArgument,$(LDResolvePathFlag),$(1))

GenerateResolveArgument		= $(call GenerateResolvePathArgument,$(dir $(1)))

GenerateResolveArguments	= $(foreach library,$(1),$(call GenerateResolveArgument,$(library)))

#
# GCC (in most cases) is actually comprised of two separate packages:
# the core GCC and binutils. The versions for these two packages are
# independent and, consequently, must be checked as such.
#

#
# Macros for checking GCC tool versions
#

GccSedTool		= [^ ]\+
GccSedVers		= [0-9\.]\+
GccSedRegExp		= ^\($(GccSedTool)\) (Ubuntu.*) \($(GccSedVers)\).*$$
GccSedCommand		= "s/$(GccSedRegExp)/\2/gp"
GccSedArgs		= $(GccSedCommand)

GccGrepRegExp		= ^\($(GccVersRegExp) *$(GccBuildRegExp)\)$$
GccGrepPattern		= "$(GccGrepRegExp)"
GccGrepArgs		= $(GccGrepPattern)

#
# Macros for checking binutils tool versions
#

BinutilsSedTool		= [^ ]\{1,\}
BinutilsSedCruft	= \(version \|(.\{1,\}) \)*
BinutilsSedVers		= \([[:digit:]]\{1,\}[-.]*\)\{1,\}
BinutilsSedBuild	= .\{1,\}

BinutilsSedRegExp	= ^GNU \(${BinutilsSedTool}\) ${BinutilsSedCruft}\(${BinutilsSedVers}\)\( *${BinutilsSedBuild}\)*$$

BinutilsSedCommand	= "s/$(BinutilsSedRegExp)/\3\5/gp"
BinutilsSedArgs		= $(BinutilsSedCommand)

BinutilsGrepRegExp	= ^\($(BinutilsVersRegExp) *$(BinutilsBuildRegExp)\)$$
BinutilsGrepPattern	= "$(BinutilsGrepRegExp)"
BinutilsGrepArgs	= $(BinutilsGrepPattern)

#
# Rule transformation definitions.
#
# Everything defined here is tool-chain specific.
#


# Transform a raw assembler file into an object file.

define tool-assemble-asm
$(Verbose)$(AS) $(ASFLAGS) $(ASOutputFlag) $@ $(ASInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform an assembler with C preprocessor file into a raw assembler file.

define tool-preprocess-asm
$(Verbose)$(CPP) $(CPPFLAGS) $(CPPOutputFlag) $@ $(CPPInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform an assembler with C preprocessor file into an object file.

define tool-preprocess-and-assemble-asm
$(Verbose)$(AS) $(ASFLAGS) $(CPPFLAGS) $(ASOutputFlag) $@ $(ASInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a C file into a preprocessed C file.

define tool-preprocess-c
$(Verbose)$(CPP) $(CPPFLAGS) $(CPPOutputFlag) $@ $(CPPInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a C++ file into a preprocessed C++ file.

define tool-preprocess-c++
$(Verbose)$(CPP) $(CPPFLAGS) $(CPPOutputFlag) $@ $(CPPInputFlag) $(call CanonicalizePath,$(<))
endef

# While a bit of a misnomer, for human readability, these next four
# implicit rules are called "disassembling". This might be more
# accurately called "compiling"; however, that means something else to
# most. Perhaps "precompiling" would be a suitable alternative.

# Transform a C file into a raw assembler file. 

define tool-preprocess-and-compile-c
$(Verbose)$(CC) $(CPPFLAGS) $(CCFLAGS) $(CCNoAssembleFlag) $(CCOutputFlag) $@ $(CCInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a C++ file into a raw assembler file. 

define tool-preprocess-and-compile-c++
$(Verbose)$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(CXXNoAssembleFlag) $(CXXOutputFlag) $@ $(CXXInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform an Objective C file into a raw assembler file. 

define tool-preprocess-and-compile-objective-c
$(Verbose)$(OJBCC) $(CPPFLAGS) $(CCFLAGS) $(CCNoAssembleFlag) $(CCOutputFlag) $@ $(CCInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform an Objective C++ file into a raw assembler file. 

define tool-preprocess-and-compile-objective-c++
$(Verbose)$(CXX) $(OBJCXXLanguage) $(CPPFLAGS) $(CXXFLAGS) $(CXXNoAssembleFlag) $(CXXOutputFlag) $@ $(CXXInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a preprocessed C file into a raw assembler file.

define tool-compile-c
$(Verbose)$(CC) $(CCFLAGS) $(CCNoAssembleFlag) $(CCOutputFlag) $@ $(CCInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a preprocessed C++ file into a raw assembler file.

define tool-compile-c++
$(Verbose)$(CXX) $(CXXFLAGS) $(CXXNoAssembleFlag) $(CXXOutputFlag) $@ $(CXXInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a preprocessed Objective C file into a raw assembler file.

define tool-compile-objective-c
$(Verbose)$(CC) $(OBJCCLanguage) $(CCFLAGS) $(CCNoAssembleFlag) $(CCOutputFlag) $@ $(CCInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a preprocessed Objective C++ file into a raw assembler file.

define tool-compile-objective-c++
$(Verbose)$(CXX) $(OBJCXXLanguage) $(CXXFLAGS) $(CXXNoAssembleFlag) $(CXXOutputFlag) $@ $(CXXInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a C file into an object file.

define tool-preprocess-compile-and-assemble-c
$(Verbose)$(CC) $(CPPFLAGS) $(CCFLAGS) $(CCNoLinkFlag) $(CCOutputFlag) $@ $(CCInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a C++ file into an object file.

define tool-preprocess-compile-and-assemble-c++
$(Verbose)$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(CXXNoLinkFlag) $(CXXOutputFlag) $@ $(CXXInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform an Objective C file into an object file.

define tool-preprocess-compile-and-assemble-objective-c
$(Verbose)$(CC) $(OBJCCLanguage) $(CPPFLAGS) $(CCFLAGS) $(CCNoLinkFlag) $(CCOutputFlag) $@ $(CCInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform an Objective C++ file into an object file.

define tool-preprocess-compile-and-assemble-objective-c++
$(Verbose)$(CXX) $(OBJCXXLanguage) $(CPPFLAGS) $(CXXFLAGS) $(CXXNoLinkFlag) $(CXXOutputFlag) $@ $(CXXInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a preprocessed C file into an object file.

define tool-compile-and-assemble-c
$(Verbose)$(CC) $(CCFLAGS) $(CCNoLinkFlag) $(CCOutputFlag) $@ $(CCInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a preprocessed C++ file into an object file.

define tool-compile-and-assemble-c++
$(Verbose)$(CXX) $(CXXFLAGS) $(CXXNoLinkFlag) $(CXXOutputFlag) $@ $(CXXInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a preprocessed C file into an object file.

define tool-compile-and-assemble-objective-c
$(Verbose)$(CC) $(OBJCCLanguage) $(CCFLAGS) $(CCNoLinkFlag) $(CCOutputFlag) $@ $(CCInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a preprocessed C++ file into an object file.

define tool-compile-and-assemble-objective-c++
$(Verbose)$(CXX) $(OBJCXXLanguage) $(CXXFLAGS) $(CXXNoLinkFlag) $(CXXOutputFlag) $@ $(CXXInputFlag) $(call CanonicalizePath,$(<))
endef

define tool-depend-asm
$(Verbose)$(DEPEND) $(CPPFLAGS) $(DEPENDFLAGS) $(DEPENDOutputFlag) $@ $(DEPENDInputFlag) $(call CanonicalizePath,$(<))
endef

define tool-depend-c
$(Verbose)$(DEPEND) $(CPPFLAGS) $(DEPENDFLAGS) $(DEPENDOutputFlag) $@ $(DEPENDInputFlag) $(call CanonicalizePath,$(<))
endef

define tool-depend-c++
$(Verbose)$(DEPEND) $(CPPFLAGS) $(DEPENDFLAGS) $(DEPENDOutputFlag) $@ $(DEPENDInputFlag) $(call CanonicalizePath,$(<))
endef

define tool-depend-objective-c
$(Verbose)$(DEPEND) $(OBJCCLanguage) $(CPPFLAGS) $(DEPENDFLAGS) $(DEPENDOutputFlag) $@ $(DEPENDInputFlag) $(call CanonicalizePath,$(<))
endef

define tool-depend-objective-c++
$(Verbose)$(DEPEND) $(OBJCXXLanguage) $(CPPFLAGS) $(DEPENDFLAGS) $(DEPENDOutputFlag) $@ $(DEPENDInputFlag) $(call CanonicalizePath,$(<))
endef

# Transform a set of objects into an archive library file.

define tool-create-archive-library
$(Verbose)$(AR) $(ARFLAGS) $(AROutputFlag) $@ $(ARInputFlag) $(filter-out $($(patsubst $(LibraryPrefix)%,%,$(notdir $(basename $@)))_GENERATION),$(?))
$(Verbose)$(RANLIB) $(RANLIBFLAGS) $@
endef

# Transform a set of objects into a shared library file.

define tool-link-shared-library
$(Verbose)$(LD) $(LDFLAGS) $(LDGCovFlag) $(LDSharedFlag) $(LDSharedNameFlag)$(@F) $(LDOutputFlag) $@ $(filter-out $(DEPLIBS) $($(patsubst $(LibraryPrefix)%,%,$(notdir $(basename $@)))_GENERATION),$^) $(call GenerateLibraryArguments,$(LDLIBS)) $(call GenerateResolveArguments,$(RESLIBS))
endef

# Transform a set of objects and libraries into an executable program.

define tool-link-program
$(Verbose)$(LD) $(LDFLAGS) $(LDGCovFlag) $(LDOutputFlag) $@ $(filter-out $(DEPLIBS) $($(notdir $(basename $@))_GENERATION),$^) $(call GenerateLibraryArguments,$(LDLIBS)) $(call GenerateResolveArguments,$(RESLIBS))
endef

# Transform a set of objects and libraries into an image

define tool-link-image
$(Verbose)$(LD) $(LDFLAGS) $(LDGCovFlag) $(LDOutputFlag) $@ $(filter-out $(DEPLIBS) $($(notdir $(basename $@))_GENERATION),$^) --start-group $(call GenerateLibraryArguments,$(LDLIBS)) --end-group --script=$(SCATTER) -Map=$(MAPFILE) $(call GenerateResolveArguments,$(RESLIBS))
endef

#
# Stock GCC options that Apple's GCC-compatible front-end doesn't support
#

LangForwardPropagation	= $(Null)

#
# Xcode has no equivalent to objcopy.
#

OBJCOPY			= $(Null)

#
# The linker and, by extension, linking are quite a bit different on
# Mac OS X than on most other UNIX-based platforms on which GCC
# runs. Explicitly override how we link a shared library or program
# executable.
#

LDSharedFlag		= -dynamiclib
LDSharedNameFlag	= -Wl,-install_name,
LDResolvePathFlag	= -Wl,-dylib_file,:

# GenerateResolvePathArgument <argument>
#
# This generates the library resolve search path of a dependent
# library. These are typically passed at the end of a link command for
# executable and shared library targets to resolve library
# dependencies not of the link target ITSELF but of the link target's
# shared libraries.
#
# Let's say that target foo depends on libbar.so and that libbar.so
# depends on liba.so and libb.so. Without specifying resolve paths,
# foo would need to link against lbar, la and lb. The first makes
# sense; however, the latter two would be surprising because, to the user
# of the 'bar' library, they are effectively hidden. Nonetheless, the
# linker still needs to know they exist and can be, eventually, resolved.
#
# So, there are two solutions to this problem. The first option, just
# specifies these "hidden" and "missing" libraries as link
# dependencies. However, as you travel "up" the library stack, you end
# up have an geometrically-increasing set of link libraries
# required. You depend on not only what you link against but
# everything they linked against and on down the dependency tree.
#
# The second option specifies these "hidden" and "missing" libraries
# as resolve dependencies without actually linking them. This keeps
# library requirements as you move "up" the library stack constant,
# that is you only depend on what you link against, not everything
# those libraries linked against.
#
# When cross-compiling, it is almost impossible to get rid of the need
# to be aware that these libraries are "missing"; however, by using
# resolve paths, the names can be resolved without having those
# "missing" libraries end up in the "NEEDED" section of the target.

GenerateResolvePathArgument	= $(call ToolGenerateArgument,$(LDResolvePathFlag),$(1))

GenerateResolveArgument		= $(call GenerateResolvePathArgument,$(1))

#
# Unlike most GCC-based toolchains, Xcode uses GCC as a compiler
# frontend; however, the assembler, linker, etc. are an amalgamation
# of binutils and Apple-only tools. Consequently, version checking is
# quite a bit more complicated.
#

#
# Macros for checking GCC tool versions
#

GccSedTool		= [^ ]*
GccSedVers		= [0-9\.]*
GccSedBuild		= [0-9]*
GccSedRegExp		= ^\($(GccSedTool)\) (GCC) \($(GccSedVers)\) (.*build \($(GccSedBuild)\)).*$$
GccSedCommand		= "s/$(GccSedRegExp)/\2 \3/gp"
GccSedArgs		= $(GccSedCommand)

GccGrepRegExp		= ^\($(GccVersRegExp) *$(GccBuildRegExp)\)$$
GccGrepPattern		= "$(GccGrepRegExp)"
GccGrepArgs		= $(GccGrepPattern)

#
# Macros for checking binutils tool versions
#

BinutilsSedTool		= [^ ]\{1,\}
BinutilsSedCruft	= \(version \|(.\{1,\}) \)*
BinutilsSedVers		= \([[:digit:]]\{1,\}[-.]*\)\{1,\}
BinutilsSedBuild	= .\{1,\}

BinutilsSedRegExp	= ^GNU \(${BinutilsSedTool}\) ${BinutilsSedCruft}\(${BinutilsSedVers}\)\( *${BinutilsSedBuild}\)*$$

BinutilsSedCommand	= "s/$(BinutilsSedRegExp)/\3\5/gp"
BinutilsSedArgs		= $(BinutilsSedCommand)

BinutilsGrepRegExp	= ^\($(BinutilsVersRegExp) *$(BinutilsBuildRegExp)\)$$
BinutilsGrepPattern	= "$(BinutilsGrepRegExp)"
BinutilsGrepArgs	= $(BinutilsGrepPattern)

