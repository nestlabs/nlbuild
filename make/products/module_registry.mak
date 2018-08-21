#
#    Copyright (c) 2015-2018 Nest Labs, Inc.
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
#      This file defines a default paths for libraries shared
#      by all platforms.

#
#  Third Party Software
#

TpsDir                          = tps

# Although freertos is in tps, its Makefile is in PlatformTpsDir, and
# the build system always puts the archives relative to the Makefile location
# in the results path.  So don't define the locations here but let the
# platform common.mak do so.

BoostDir                        = $(TpsDir)/boost
BoostIncludeDirs                = $(BoostDir)/include
BoostLibraryDir                 = $(BoostDir)/lib
BoostNames                      = boost_filesystem boost_system boost_python
BoostSrcPath                    = $(BuildRoot)/$(BoostDir)
BoostPath                       = $(call GenerateResultPaths,.,$(BoostDir))
BoostIncludePaths               = $(call GenerateResultPaths,.,$(BoostIncludeDirs))
BoostLibraryPaths               = $(call GenerateResultPaths,$(BoostLibraryDir),$(BoostNames))
BoostDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(BoostLibraryDir),$(BoostNames))

CFDir                           = $(TpsDir)/opencflite
CFIncludeDirs                   = $(CFDir)/usr/include
CFLibraryDir                    = $(CFDir)/usr/lib
CFNames                         = CoreFoundation
CFSrcPath                       = $(BuildRoot)/$(CFDir)
CFPath                          = $(call GenerateResultPaths,.,$(CFDir))
CFIncludePaths                  = $(call GenerateResultPaths,.,$(CFIncludeDirs))
CFLibraryPaths                  = $(call GenerateResultPaths,$(CFLibraryDir),$(CFNames))
CFDependPaths                   = $(call GenerateArchiveLibraryResultPaths,$(CFLibraryDir),$(CFNames))

CMSISDir                        = $(TpsDir)/CMSIS
CMSISIncludeDirs                = $(CMSISDir)/include
CMSISLibraryDir                 = $(CMSISDir)
CMSISNames                      = cmsis-core
CMSISSrcPath                    = $(BuildRoot)/$(CMSISDir)
CMSISPath                       = $(call GenerateResultPaths,.,$(CMSISDir))
CMSISIncludePaths               = $(call GenerateResultPaths,.,$(CMSISIncludeDirs))
CMSISLibraryPaths               = $(call GenerateResultPaths,$(CMSISLibraryDir),$(CMSISNames))
CMSISDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(CMSISLibraryDir),$(CMSISNames))

CoremarkDir                     = $(TpsDir)/coremark
CoremarkIncludeDirs             = $(CoremarkDir)
CoremarkLibraryDir              = $(CoremarkDir)
CoremarkNames                   = coremark
CoremarkSrcPath                 = $(BuildRoot)/$(CoremarkDir)
CoremarkPath                    = $(call GenerateResultPaths,.,$(CoremarkDir))
CoremarkIncludePaths            = $(call GenerateResultPaths,.,$(CoremarkIncludeDirs))
CoremarkLibraryPaths            = $(call GenerateResultPaths,$(CoremarkLibraryDir),$(CoremarkNames))
CoremarkDependPaths             = $(call GenerateArchiveLibraryResultPaths,$(CoremarkLibraryDir),$(CoremarkNames))

NordicDir                       = $(TpsDir)/nordic
NordicIncludeDir                = . nrf52x/device nrf52x/toolchain nrf_cc310/include nrf_cc310_bl/include
NordicLibraryDir                = $(NordicDir)
NordicNames                     = cc310_gcc_0.9.0
NordicSrcPath                   = $(BuildRoot)/$(NordicDir)
NordicPath                      = $(call GenerateResultPaths,.,$(NordicDir))
NordicIncludePaths              = $(call GenerateResultPaths,$(NordicDir),$(NordicIncludeDir))
NordicLibraryPaths              = $(call GenerateResultPaths,$(NordicLibraryDir),$(NordicNames))
NordicDependPaths               = $(call GenerateArchiveLibraryResultPaths,$(NordicLibraryDir),$(NordicNames))

NordicBLNames                   = nrf_cc310_bl
NordicBLLibraryPaths            = $(call GenerateResultPaths,$(NordicLibraryDir),$(NordicBLNames))
NordicBLDependPaths             = $(call GenerateArchiveLibraryResultPaths,$(NordicLibraryDir),$(NordicBLNames))

ICUDir                          = $(TpsDir)/icu
ICUIncludeDirs                  = $(ICUDir)/usr/include
ICULibraryDir                   = $(ICUDir)/usr/lib
ICUNames                        = icuuc icui18n icudata
ICUSrcPath                      = $(BuildRoot)/$(ICUDir)
ICUPath                         = $(call GenerateResultPaths,.,$(ICUDir))
ICUIncludePaths                 = $(call GenerateResultPaths,.,$(ICUIncludeDir ))
ICULibraryPaths                 = $(call GenerateResultPaths,$(ICULibraryDir),$(ICUNames))
ICUDependPaths                  = $(call GenerateArchiveLibraryResultPaths,$(ICULibraryDir),$(ICUNames))

MinizDir                        = $(TpsDir)/miniz
MinizSrcPath                    = $(BuildRoot)/$(MinizDir)

OpenSSLDir                      = $(TpsDir)/openssl
OpenSSLIncludeDirs              = $(OpenSSLDir)/usr/include
OpenSSLLibraryDir               = $(OpenSSLDir)/usr/lib
OpenSSLNames                    = crypto
OpenSSLSrcPath                  = $(BuildRoot)/$(OpenSSLDir)
OpenSSLPath                     = $(call GenerateResultPaths,.,$(OpenSSLDir))
OpenSSLIncludePaths             = $(call GenerateResultPaths,.,$(OpenSSLIncludeDirs))
OpenSSLLibraryPaths             = $(call GenerateResultPaths,$(OpenSSLLibraryDir),$(OpenSSLNames))
OpenSSLDependPaths              = $(call GenerateArchiveLibraryResultPaths,$(OpenSSLLibraryDir),$(OpenSSLNames))

PythonDir                       = $(TpsDir)/python
PythonIncludeDirs               = $(PythonDir)/include/python2.7
PythonLibraryDir                = $(PythonDir)/lib
PythonNames                     = python2.7
PythonSrcPath                   = $(BuildRoot)/$(PythonDir)
PythonPath                      = $(call GenerateResultPaths,.,$(PythonDir))
PythonIncludePaths              = $(call GenerateResultPaths,.,$(PythonIncludeDirs))
PythonLibraryPaths              = $(call GenerateResultPaths,$(PythonLibraryDir),$(PythonNames))
PythonDependPaths               = $(call GenerateArchiveLibraryResultPaths,$(PythonLibraryDir),$(PythonNames))

SavannahNonGNULwipDir           = $(TpsDir)/savannah.nongnu.org/lwip
SavannahNonGNULwipSrcPath       = $(BuildRoot)/$(SavannahNonGNULwipDir)

TzDir                           = $(TpsDir)/tz
TzIncludeDirs                   = $(TzDir)/usr/include
TzLibraryDir                    = $(TzDir)/lib
TzNames                         = tz
TzSrcPath                       = $(BuildRoot)/$(TzDir)
TzPath                          = $(call GenerateResultPaths,.,$(TzDir))
TzIncludePaths                  = $(call GenerateResultPaths,.,$(TzIncludeDirs))
TzLibraryPaths                  = $(call GenerateResultPaths,$(TzLibraryDir),$(TzNames))
TzDependPaths                   = $(call GenerateArchiveLibraryResultPaths,$(TzLibraryDir),$(TzNames))

GTestDir                        = $(TpsDir)/gtest
GTestTestsDir                   = $(GTestDir)/tests
GTestIncludeDirs                = $(GTestDir)/include \
                                  $(GTestTestsDir)/nlnetworkmanager
GTestLibraryDir                 = $(GTestDir)
GTestNames                      = gtest gtest-tests
GTestSrcPath                    = $(BuildRoot)/$(GTestDir)
GTestPath                       = $(call GenerateResultPaths,.,$(GTestDir))
GTestIncludePaths               = $(addprefix $(BuildRoot)/,$(GTestIncludeDirs))
GTestLibraryPaths               = $(call GenerateResultPaths,$(GTestDir),gtest) \
                                  $(call GenerateResultPaths,$(GTestTestsDir), gtest-tests)
GTestDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(GTestDir),gtest) \
                                  $(call GenerateArchiveLibraryResultPaths,$(GTestTestsDir), gtest-tests)

#
# Obsolescent Libraries
#

# In moving stash.nestlabs.com/platform/lwip.git to stash.nestlabs.com/tps/lwip.git the
# path to the LwIP sources move to the root of the repository. These older variables still
# point to the location of the old platform LwIP repository structure, where the sources
# are pulled into a git subtree. These variables are still used in build logic for products
# that have not yet migrated to the new LwIP sources.
LwipDir                         = $(TpsDir)/lwip
LwipSrcPath                     = $(BuildRoot)/$(LwipDir)

#
#  Nest Labs First-Party Libraries
#

FpsDir                          = fps
FpsSrcPath                      = $(BuildRoot)/$(FpsDir)

NlAssertDir                     = $(FpsDir)/nlassert
NlAssertIncludeDir              = $(NlAssertDir)/include
NlAssertLibraryDir              = $(NlAssertDir)
NlAssertNames                   =
NlAssertSrcPath                 = $(BuildRoot)/$(NlAssertDir)
NlAssertPath                    = $(call GenerateResultPaths,.,$(NlAssertDir))
NlAssertIncludePaths            = $(call GenerateResultPaths,.,$(NlAssertIncludeDir))
NlAssertLibraryPaths            =
NlAssertDependPaths             =

NlERDir                         = $(FpsDir)/embedded-runtime
NlERIncludeDirs                 = $(NlERDir)/include $(NlERDir)/freertos $(NlERDir)/products/$(BuildProduct)
NlERLibraryDir                  = $(NlERDir)
NlERNames                       = nlerarch nlerfreertos nlershared
ifeq ($(BuildConfig),unittest)
NlERNames                      += nlertest
endif
NlERPath                        = $(call GenerateResultPaths,.,$(NlERDir))
NlERSrcPath                     = $(BuildRoot)/$(NlERDir)
NlERIncludePaths                = $(call GenerateResultPaths,.,$(NlERIncludeDirs))
NlERLibraryPaths                = $(call GenerateResultPaths,$(NlERLibraryDir),$(NlERNames))
NlERDependPaths                 = $(call GenerateArchiveLibraryResultPaths,$(NlERLibraryDir),$(NlERNames))

NlEmbeddedUtilsDir              = $(FpsDir)/embedded-utilities
NlEmbeddedUtilsIncludeDirs      = $(NlEmbeddedUtilsDir)/include
NlEmbeddedUtilsLibraryDir       = $(NlEmbeddedUtilsDir)/lib
NlEmbeddedUtilsNames            = nleushared
NlEmbeddedUtilsSrcPath          = $(BuildRoot)/$(NlEmbeddedUtilsDir)
NlEmbeddedUtilsPath             = $(call GenerateResultPaths,.,$(NlEmbeddedUtilsDir))
NlEmbeddedUtilsIncludePaths     = $(call GenerateResultPaths,.,$(NlEmbeddedUtilsIncludeDirs))
NlEmbeddedUtilsLibraryPaths     = $(call GenerateResultPaths,$(NlEmbeddedUtilsLibraryDir),$(NlEmbeddedUtilsNames))
NlEmbeddedUtilsDependPaths      = $(call GenerateArchiveLibraryResultPaths,$(NlEmbeddedUtilsLibraryDir),$(NlEmbeddedUtilsNames))

NlFSMDir                        = $(FpsDir)/nlfsm
NlFSMIncludeDirs                = $(NlFSMDir)/include
NlFSMLibraryDir                 = $(NlFSMDir)
NlFSMNames                      = nlfsm
NlFSMSrcPath                    = $(BuildRoot)/$(NlFSMDir)
NlFSMPath                       = $(call GenerateResultPaths,.,$(NlFSMDir))
NlFSMIncludePaths               = $(call GenerateResultPaths,.,$(NlFSMIncludeDirs))
NlFSMLibraryPaths               = $(call GenerateResultPaths,$(NlFSMLibraryDir),$(NlFSMNames))
NlFSMDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(NlFSMLibraryDir),$(NlFSMNames))

NlModelDir                      = $(NlSystemDir)/nlmodel
NlModelIncludeDirs              = $(NlModelDir)/include
NlModelNames                    = nlmodel
NlModelPath                     = $(call GenerateResultPaths,.,$(NlModelDir))
NlModelSrcPath                  = $(BuildRoot)/$(NlModelDir)
NlModelIncludePaths             = $(call GenerateResultPaths,.,$(NlModelIncludeDirs))
NlModelLibraryPaths             = $(call GenerateResultPaths,$(NlModelDir),$(NlModelNames))
NlModelDependPaths              = $(call GenerateArchiveLibraryResultPaths,$(NlModelDir),$(NlModelNames))

NlNetworkManagerDir             = $(FpsDir)/nlnetworkmanager
NlNetworkManagerIncludeDirs     = $(NlNetworkManagerDir)/include \
                                  $(NlNetworkManagerDir)/daemon \
                                  $(NlNetworkManagerDir)/client/include
NlNetworkManagerLibraryDir      = $(NlNetworkManagerDir)
NlNetworkManagerNames           = daemon/nlnetworkmanager-daemon client/nlnetworkmanager-client common/nlnetworkmanager-common
NlNetworkManagerSrcPath         = $(BuildRoot)/$(NlNetworkManagerDir)
NlNetworkManagerPath            = $(call GenerateResultPaths,.,$(NlNetworkManagerDir))
NlNetworkManagerIncludePaths    = $(addprefix $(BuildRoot)/,$(NlNetworkManagerIncludeDirs))
NlNetworkManagerLibraryPaths    = $(call GenerateResultPaths,$(NlNetworkManagerLibraryDir),$(NlNetworkManagerNames))
NlNetworkManagerDependPaths     = $(call GenerateArchiveLibraryResultPaths,$(NlNetworkManagerLibraryDir)/daemon,nlnetworkmanager-daemon) \
                                  $(call GenerateArchiveLibraryResultPaths,$(NlNetworkManagerLibraryDir)/client,nlnetworkmanager-client) \
                                  $(call GenerateArchiveLibraryResultPaths,$(NlNetworkManagerLibraryDir)/common,nlnetworkmanager-common)

NlSimUtilsDir                   = $(FpsDir)/nlsimutils
NlSimUtilsSrcPath               = $(BuildRoot)/$(NlSimUtilsDir)

CFUtilitiesDir                  = $(NlSimUtilsDir)/CFUtilities
CFUtilitiesIncludeDir           = $(CFUtilitiesDir)/include
CFUtilitiesLibraryDir           = $(CFUtilitiesDir)
CFUtilitiesNames                = CFUtilities
CFUtilitiesSrcPath				= $(NlSimUtilsSrcPath)/$(CFUtilitiesNames)
CFUtilitiesPath                 = $(call GenerateResultPaths,.,$(CFUtilitiesDir))
CFUtilitiesIncludePath          = $(call GenerateResultPaths,.,$(CFUtilitiesIncludeDir))
CFUtilitiesLibraryPath          = $(call GenerateResultPaths,.,$(CFUtilitiesLibraryDir))
CFUtilitiesLibraryPaths         = $(call GenerateResultPaths,$(CFUtilitiesLibraryDir),$(CFUtilitiesNames))
CFUtilitiesDependPaths          = $(call GenerateArchiveLibraryResultPaths,$(CFUtilitiesLibraryDir),$(CFUtilitiesNames))

NlDebuggerDir                   = $(NlSimUtilsDir)/nldebugger
NlDebuggerIncludeDirs           = $(NlDebuggerDir)/include
NlDebuggerLibraryDir            = $(NlDebuggerDir)
NlDebuggerNames                 = nldebugger
NlDebuggerPath                  = $(call GenerateResultPaths,.,$(NlDebuggerDir))
NlDebuggerIncludePaths          = $(call GenerateResultPaths,.,$(NlDebuggerIncludeDirs))
NlDebuggerLibraryPath           = $(call GenerateResultPaths,.,$(NlDebuggerLibraryDir))
NlDebuggerLibraryPaths          = $(call GenerateResultPaths,$(NlDebuggerLibraryDir),$(NlDebuggerNames))
NlDebuggerDependPaths           = $(call GenerateArchiveLibraryResultPaths,$(NlDebuggerLibraryDir),$(NlDebuggerNames))

NlFreeRTOSDir                   = $(NlSimUtilsDir)/nlfreertos-pthreads
NlFreeRTOSIncludeDirs           = $(NlFreeRTOSDir)
NlFreeRTOSLibraryDir            = $(NlFreeRTOSDir)
NlFreeRTOSSrcPath               = $(BuildRoot)/$(NlFreeRTOSDir)
NlFreeRTOSNames                 = nlfreertos-pthreads
NlFreeRTOSPaths                 = $(call GenerateResultPaths,.,$(NlFreeRTOSDir))
NlFreeRTOSIncludePaths          = $(call GenerateResultPaths,.,$(NlFreeRTOSIncludeDirs))
NlFreeRTOSLibraryPaths          = $(call GenerateResultPaths,$(NlFreeRTOSLibraryDir),$(NlFreeRTOSNames))
NlFreeRTOSDependPaths           = $(call GenerateArchiveLibraryResultPaths,$(NlFreeRTOSLibraryDir),$(NlFreeRTOSNames))

NlLwipSimDir                    = $(NlSimUtilsDir)/nllwipsim
NlLwipSimIncludeDirs            = $(NlLwipSimDir)/include
NlLwipSimLibraryDir             = $(NlLwipSimDir)
NlLwipSimNames                  = nllwipsim
NlLwipSimPath                   = $(call GenerateResultPaths,.,$(NlLwipSimDir))
NlLwipSimIncludePaths           = $(call GenerateResultPaths,.,$(NlLwipSimIncludeDirs))
NlLwipSimLibraryPaths           = $(call GenerateResultPaths,$(NlLwipSimLibraryDir),$(NlLwipSimNames))
NlLwipSimDependPaths            = $(call GenerateArchiveLibraryResultPaths,$(NlLwipSimLibraryDir),$(NlLwipSimNames))

NlSandboxDir                    = $(NlSimUtilsDir)/nlsandbox
NlSandboxIncludeDirs            = $(NlSandboxDir)/include
NlSandboxLibraryDir             = $(NlSandboxDir)
NlSandboxNames                  = nlsandbox
NlSandboxPath                   = $(call GenerateResultPaths,.,$(NlSandboxDir))
NlSandboxIncludePaths           = $(call GenerateResultPaths,.,$(NlSandboxIncludeDirs))
NlSandboxLibraryPath            = $(call GenerateResultPaths,.,$(NlSandboxLibraryDir))
NlSandboxLibraryPaths           = $(call GenerateResultPaths,$(NlSandboxLibraryDir),$(NlSandboxNames))
NlSandboxDependPaths            = $(call GenerateArchiveLibraryResultPaths,$(NlSandboxLibraryDir),$(NlSandboxNames))

NlSystemDir                     = $(FpsDir)/nlsystem
NlSystemResultDir               = $(call GenerateResultPaths,.,$(NlSystemDir))

NlBacktraceDir                  = $(NlSystemDir)/nlbacktrace
NlBacktraceIncludeDirs          = $(NlBacktraceDir)/include
NlBacktraceLibraryDir           = $(NlBacktraceDir)
NlBacktraceNames                = nlbacktrace
NlBacktraceSrcPath              = $(BuildRoot)/$(NlBacktraceDir)
NlBacktracePath                 = $(call GenerateResultPaths,.,$(NlBacktraceDir))
NlBacktraceIncludePaths         = $(call GenerateResultPaths,.,$(NlBacktraceIncludeDirs))
NlBacktraceLibraryPaths         = $(call GenerateResultPaths,$(NlBacktraceLibraryDir),$(NlBacktraceNames))
NlBacktraceDependPaths          = $(call GenerateArchiveLibraryResultPaths,$(NlBacktraceLibraryDir),$(NlBacktraceNames))

NlBinaryUtilsDir                = $(NlSystemDir)/nlbinary-utils
NlBinaryUtilsIncludeDirs        = $(NlBinaryUtilsDir)/include
NlBinaryUtilsLibraryDir         = $(NlBinaryUtilsDir)/lib
NlBinaryUtilsNames              = nlbinaryutils
NlBinaryUtilsSrcPath            = $(BuildRoot)/$(NlBinaryUtilsDir)
NlBinaryUtilsPath               = $(call GenerateResultPaths,.,$(NlBinaryUtilsDir))
NlBinaryUtilsIncludePaths       = $(call GenerateResultPaths,.,$(NlBinaryUtilsIncludeDirs))
NlBinaryUtilsLibraryPaths       = $(call GenerateResultPaths,$(NlBinaryUtilsLibraryDir),$(NlBinaryUtilsNames))
NlBinaryUtilsDependPaths        = $(call GenerateArchiveLibraryResultPaths,$(NlBinaryUtilsLibraryDir),$(NlBinaryUtilsNames))

NlBreadcrumbsDir                = $(NlSystemDir)/nlbreadcrumbs
NlBreadcrumbsIncludeDirs        = $(NlBreadcrumbsDir)/include
NlBreadcrumbsNames              = nlbreadcrumbs
NlBreadcrumbsPath               = $(call GenerateResultPaths,.,$(NlBreadcrumbsDir))
NlBreadcrumbsSrcPath            = $(BuildRoot)/$(NlBreadcrumbsDir)
NlBreadcrumbsIncludePaths       = $(call GenerateResultPaths,.,$(NlBreadcrumbsIncludeDirs))
NlBreadcrumbsLibraryPaths       = $(call GenerateResultPaths,$(NlBreadcrumbsDir),$(NlBreadcrumbsNames))
NlBreadcrumbsDependPaths        = $(call GenerateArchiveLibraryResultPaths,$(NlBreadcrumbsDir),$(NlBreadcrumbsNames))

# Breadcrumb infrastructure forces breadcrumbs-local.h to be in .build/Makefile/...
# For those modules which use a makefile name other than "Makefile", use this path
# to locate breadcrumbs-local.h.
NlBreadcrumbsLocalIncludePaths  = $(subst $(word 2,$(subst /, ,$(subst //,/,$(BuildDirectory)))),Makefile,$(BuildDirectory))

NlXmodemDir                        = $(NlSystemDir)/nlxmodem
NlXmodemIncludeDirs                = $(NlXmodemDir)/include
NlXmodemNames                      = nlxmodem
NlXmodemPath                       = $(call GenerateResultPaths,.,$(NlXmodemDir))
NlXmodemSrcPath                    = $(BuildRoot)/$(NlXmodemDir)
NlXmodemIncludePaths               = $(call GenerateResultPaths,.,$(NlXmodemIncludeDirs))
NlXmodemLibraryPaths               = $(call GenerateResultPaths,$(NlXmodemDir),$(NlXmodemNames))
NlXmodemDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(NlXmodemDir),$(NlXmodemNames))

NlCryptoDir                        = $(NlSystemDir)/nlcrypto
NlCryptoIncludeDirs                = $(NlCryptoDir)/include
NlCryptoNames                      = nlcrypto
NlCryptoPath                       = $(call GenerateResultPaths,.,$(NlCryptoDir))
NlCryptoSrcPath                    = $(BuildRoot)/$(NlCryptoDir)
NlCryptoIncludePaths               = $(call GenerateResultPaths,.,$(NlCryptoIncludeDirs))
NlCryptoLibraryPaths               = $(call GenerateResultPaths,$(NlCryptoDir),$(NlCryptoNames))
NlCryptoDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(NlCryptoDir),$(NlCryptoNames))

NlCrcDir                        = $(NlSystemDir)/nlcrc
NlCrcIncludeDirs                = $(NlCrcDir)/include
NlCrcNames                      = nlcrc
NlCrcPath                       = $(call GenerateResultPaths,.,$(NlCrcDir))
NlCrcSrcPath                    = $(BuildRoot)/$(NlCrcDir)
NlCrcIncludePaths               = $(call GenerateResultPaths,.,$(NlCrcIncludeDirs))
NlCrcLibraryPaths               = $(call GenerateResultPaths,$(NlCrcDir),$(NlCrcNames))
NlCrcDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(NlCrcDir),$(NlCrcNames))

NlDataStructuresDir             = $(NlSystemDir)/nldatastructures
NlDataStructuresIncludeDirs     = $(NlDataStructuresDir)/include
NlDataStructuresLibraryDir      = $(NlDataStructuresDir)/lib
NlDataStructuresNames           = nlds
NlDataStructuresSrcPath         = $(BuildRoot)/$(NlDataStructuresDir)
NlDataStructuresPath            = $(call GenerateResultPaths,.,$(NlDataStructuresDir))
NlDataStructuresIncludePaths    = $(call GenerateResultPaths,.,$(NlDataStructuresIncludeDirs))
NlDataStructuresLibraryPaths    = $(call GenerateResultPaths,$(NlDataStructuresLibraryDir),$(NlDataStructuresNames))
NlDataStructuresDependPaths     = $(call GenerateArchiveLibraryResultPaths,$(NlDataStructuresLibraryDir),$(NlDataStructuresNames))

NlEMallocDir                    = $(NlSystemDir)/nlemalloc
NlEMallocIncludeDirs            = $(NlEMallocDir)/include
NlEMallocLibraryDir             = $(NlEMallocDir)/lib
NlEMallocNames                  = nlemalloc
NlEMallocSrcPath                = $(BuildRoot)/$(NlEMallocDir)
NlEMallocPath                   = $(call GenerateResultPaths,.,$(NlEMallocDir))
NlEMallocIncludePaths           = $(call GenerateResultPaths,.,$(NlEMallocIncludeDirs))
NlEMallocLibraryPaths           = $(call GenerateResultPaths,$(NlEMallocLibraryDir),$(NlEMallocNames))
NlEMallocDependPaths            = $(call GenerateArchiveLibraryResultPaths,$(NlEMallocLibraryDir),$(NlEMallocNames))

NlEnvDir                        = $(NlSystemDir)/nlenv
NlEnvIncludeDirs                = include
NlEnvLibraryDir                 = $(NlEnvDir)
NlEnvNames                      = nlenv
NlEnvSrcPath                    = $(BuildRoot)/$(NlEnvDir)
NlEnvIncludePaths               = $(call GenerateResultPaths,$(NlEnvDir),$(NlEnvIncludeDirs))
NlEnvLibraryPaths               = $(call GenerateResultPaths,$(NlEnvLibraryDir),$(NlEnvNames))
NlEnvDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(NlEnvLibraryDir),$(NlEnvNames))

TlvStorageDir                   = $(NlSystemDir)/tlvstorage
TlvStorageIncludeDirs           = include
TlvStorageLibraryDir            = $(TlvStorageDir)
TlvStorageNames                 = tlvstorage
TlvStorageSrcPath               = $(BuildRoot)/$(TlvStorageDir)
TlvStorageIncludePaths          = $(call GenerateResultPaths,$(TlvStorageDir),$(TlvStorageIncludeDirs))
TlvStorageLibraryPaths          = $(call GenerateResultPaths,$(TlvStorageLibraryDir),$(TlvStorageNames))
TlvStorageDependPaths           = $(call GenerateArchiveLibraryResultPaths,$(TlvStorageLibraryDir),$(TlvStorageNames))

NlShellCommandsDir              = $(NlSystemDir)/nlshellcommands
NlShellCommandsIncludeDirs      = $(NlShellCommandsDir)/include
NlShellCommandsLibraryDir       = $(NlShellCommandsDir)
NlShellCommandsNames            = nlshellcommands
NlShellCommandsSrcPath          = $(BuildRoot)/$(NlShellCommandsDir)
NlShellCommandsPath             = $(call GenerateResultPaths,.,$(NlShellCommandsDir))
NlShellCommandsIncludePaths     = $(call GenerateResultPaths,.,$(NlShellCommandsIncludeDirs))
NlShellCommandsLibraryPaths     = $(call GenerateResultPaths,$(NlShellCommandsLibraryDir),$(NlShellCommandsNames))
NlShellCommandsDependPaths      = $(call GenerateArchiveLibraryResultPaths,$(NlShellCommandsLibraryDir),$(NlShellCommandsNames))

NlLibCLiteDir                   = $(FpsDir)/nllibc-lite
NlLibCLiteIncludeDirs           = include
NlLibCLiteLibraryDir            = $(NlLibCLiteDir)
NlLibCLiteNames                 = nllibc
NlLibCLiteSrcPath               = $(BuildRoot)/$(NlLibCLiteDir)
NlLibCLitePath                  = $(call GenerateResultPaths,.,$(NlLibCLiteDir))
NlLibCLiteLibraryPaths          = $(call GenerateResultPaths,$(NlLibCLiteLibraryDir),$(NlLibCLiteNames))
NlLibCLiteIncludePaths          = $(call GenerateResultPaths,$(NlLibCLiteDir),$(NlLibCLiteIncludeDirs))
NlLibCLiteDependPaths           = $(call GenerateArchiveLibraryResultPaths,$(NlLibCLiteLibraryDir),$(NlLibCLiteNames))

NlLwipDir                       = $(FpsDir)/nllwip
NlLwipIncludeDirs               = $(NlLwipDir)/include
NlLwipLibraryDir                = $(NlLwipDir)
NlLwipNames                     = nllwip
NlLwipSrcPath                   = $(BuildRoot)/$(NlLwipDir)
NlLwipPath                      = $(call GenerateResultPaths,.,$(NlLwipDir))
NlLwipLibraryPaths              = $(call GenerateResultPaths,$(NlLwipLibraryDir),$(NlLwipNames))
NlLwipIncludePaths              = $(call GenerateResultPaths,.,$(NlLwipIncludeDirs))
NlLwipIncludePath               = $(NlLwipIncludePaths)
NlLwipDependPaths               = $(call GenerateArchiveLibraryResultPaths,$(NlLwipLibraryDir),$(NlLwipNames))

NlMiniShellDir                  = $(NlSystemDir)/nlminishell
NlMiniShellIncludeDirs          = $(NlMiniShellDir)/include
NlMiniShellNames                = nlminishell
NlMiniShellPath                 = $(call GenerateResultPaths,.,$(NlMiniShellDir))
NlMiniShellSrcPath              = $(BuildRoot)/$(NlMiniShellDir)
NlMiniShellIncludePaths         = $(call GenerateResultPaths,.,$(NlMiniShellIncludeDirs))
NlMiniShellLibraryPaths         = $(call GenerateResultPaths,$(NlMiniShellDir),$(NlMiniShellNames))
NlMiniShellDependPaths          = $(call GenerateArchiveLibraryResultPaths,$(NlMiniShellDir),$(NlMiniShellNames))

NlOpenThreadDir                 = $(FpsDir)/nlopenthread
NlOpenThreadIncludeDirs         = include
NlOpenThreadLibraryDir          =
NlOpenThreadName                = nlopenthread
NlOpenThreadSrcPath             = $(BuildRoot)/$(NlOpenThreadDir)
NlOpenThreadIncludePaths        = $(BuildRoot)/$(NlOpenThreadDir)/$(NlOpenThreadIncludeDirs)
NlOpenThreadLibraryPaths        = $(call GenerateResultPaths,$(NlOpenThreadDir),$(NlOpenThreadName))
NlOpenThreadDependPaths         = $(call GenerateArchiveLibraryResultPaths,$(NlOpenThreadDir)/$(NlOpenThreadLibraryDir),$(NlOpenThreadName))

NlPlatformDir                   = $(FpsDir)/nlplatform/nlplatform
NlPlatformIncludeDir            = $(NlPlatformDir)/include
NlPlatformLibraryDir            = $(NlPlatformDir)
NlPlatformNames                 = nlplatform
NlPlatformSrcPath               = $(BuildRoot)/$(NlPlatformDir)
NlPlatformPath                  = $(call GenerateResultPaths,.,$(NlPlatformDir))
# Since nlplatform.h includes nlplatform_soc.h, always include NlPlatformSocIncludePaths as part
# of NLPlatformIncludePaths.  NlPlatformSocIncludePaths is defined in product common.mak.
NlPlatformIncludePaths          = $(call GenerateResultPaths,.,$(NlPlatformIncludeDir)) $(NlPlatformSocIncludePaths)
NlPlatformLibraryPaths          = $(call GenerateResultPaths,$(NlPlatformLibraryDir),$(NlPlatformNames))
NlPlatformDependPaths           = $(call GenerateArchiveLibraryResultPaths,$(NlPlatformLibraryDir),$(NlPlatformNames))

NlPlatformNoRTOSDir             = $(NlPlatformDir)
NlPlatformNoRTOSLibraryDir      = $(NlPlatformNoRTOSDir)
NlPlatformNoRTOSNames           = nlplatform_nortos
NlPlatformNoRTOSSrcPath         = $(BuildRoot)/$(NlPlatformNoRTOSDir)
NlPlatformNoRTOSPath            = $(call GenerateResultPaths,.,$(NlPlatformNoRTOSDir))
NlPlatformNoRTOSIncludePaths    = $(NlPlatformIncludePaths)
NlPlatformNoRTOSLibraryPaths    = $(call GenerateResultPaths,$(NlPlatformNoRTOSLibraryDir),$(NlPlatformNoRTOSNames))
NlPlatformNoRTOSDependPaths     = $(call GenerateArchiveLibraryResultPaths,$(NlPlatformNoRTOSLibraryDir),$(NlPlatformNoRTOSNames))

NlPlatformNRF52xDir             = $(FpsDir)/nlplatform/nlplatform_nrf52x
NlPlatformNRF52xIncludeDir      = $(NlPlatformNRF52xDir)/include
NlPlatformNRF52xLibraryDir      = $(NlPlatformNRF52xDir)
NlPlatformNRF52xNames           = nlplatform_nrf52x
NlPlatformNRF52xSrcPath         = $(BuildRoot)/$(NlPlatformNRF52xDir)
NlPlatformNRF52xPath            = $(call GenerateResultPaths,.,$(NlPlatformNRF52xDir))
## because nlplatform_soc.h includes nordic headers, easier if NlPlatformSocIncludePaths
## also includes NordicIncludePaths.  same with CMSIS.
NlPlatformNRF52xIncludePaths    = $(call GenerateResultPaths,.,$(NlPlatformNRF52xIncludeDir)) $(NordicIncludePaths) $(CMSISIncludePaths)
NlPlatformNRF52xLibraryPaths    = $(call GenerateResultPaths,$(NlPlatformNRF52xLibraryDir),$(NlPlatformNRF52xNames))
NlPlatformNRF52xDependPaths     = $(call GenerateArchiveLibraryResultPaths,$(NlPlatformNRF52xLibraryDir),$(NlPlatformNRF52xNames))

NlPlatformNRF52xBootDir          = $(NlPlatformNRF52xDir)
NlPlatformNRF52xBootLibraryDir   = $(NlPlatformNRF52xBootDir)
NlPlatformNRF52xBootNames        = nlplatform_nrf52x_boot
NlPlatformNRF52xBootSrcPath      = $(BuildRoot)/$(NlPlatformNRF52xBootDir)
NlPlatformNRF52xBootPath         = $(call GenerateResultPaths,.,$(NlPlatformNRF52xBootDir))
NlPlatformNRF52xBootIncludePaths = $(NlPlatformNRF52xIncludePaths)
NlPlatformNRF52xBootLibraryPaths = $(call GenerateResultPaths,$(NlPlatformNRF52xBootLibraryDir),$(NlPlatformNRF52xBootNames))
NlPlatformNRF52xBootDependPaths  = $(call GenerateArchiveLibraryResultPaths,$(NlPlatformNRF52xBootLibraryDir),$(NlPlatformNRF52xBootNames))

NlPlatformNRF52xNlRadioDir          = $(NlPlatformNRF52xDir)
NlPlatformNRF52xNlRadioLibraryDir   = $(NlPlatformNRF52xNlRadioDir)
NlPlatformNRF52xNlRadioNames        = nlplatform_nrf52x_nlradio
NlPlatformNRF52xNlRadioSrcPath      = $(BuildRoot)/$(NlPlatformNRF52xNlRadioDir)
NlPlatformNRF52xNlRadioPath         = $(call GenerateResultPaths,.,$(NlPlatformNRF52xNlRadioDir))
NlPlatformNRF52xNlRadioIncludePaths = $(NlPlatformNRF52xIncludePaths)
NlPlatformNRF52xNlRadioLibraryPaths = $(call GenerateResultPaths,$(NlPlatformNRF52xNlRadioLibraryDir),$(NlPlatformNRF52xNlRadioNames))
NlPlatformNRF52xNlRadioDependPaths  = $(call GenerateArchiveLibraryResultPaths,$(NlPlatformNRF52xNlRadioLibraryDir),$(NlPlatformNRF52xNlRadioNames))

NlPlatformSimDir                = $(FpsDir)/nlplatform/nlplatform_sim
NlPlatformSimIncludeDir         = $(NlPlatformSimDir)/include
NlPlatformSimLibraryDir         = $(NlPlatformSimDir)
NlPlatformSimNames              = nlplatform_sim
NlPlatformSimSrcPath            = $(BuildRoot)/$(NlPlatformSimDir)
NlPlatformSimPath               = $(call GenerateResultPaths,.,$(NlPlatformSimDir))
NlPlatformSimIncludePaths       = $(call GenerateResultPaths,.,$(NlPlatformSimIncludeDir))
NlPlatformSimLibraryPaths       = $(call GenerateResultPaths,$(NlPlatformSimLibraryDir),$(NlPlatformSimNames))
NlPlatformSimDependPaths        = $(call GenerateArchiveLibraryResultPaths,$(NlPlatformSimLibraryDir),$(NlPlatformSimNames))

NlVersionDir                    = $(NlSystemDir)/nlversion
NlVersionIncludeDirs            = $(NlVersionDir)/include
NlVersionLibraryDir             = $(NlVersionDir)/lib
NlVersionNames                  = nlversion
NlVersionSrcPath                = $(BuildRoot)/$(NlVersionDir)
NlVersionPath                   = $(call GenerateResultPaths,.,$(NlVersionDir))
NlVersionIncludePaths           = $(call GenerateResultPaths,.,$(NlVersionIncludeDirs))
NlVersionLibraryPaths           = $(call GenerateResultPaths,$(NlVersionLibraryDir),$(NlVersionNames))
NlVersionDependPaths            = $(call GenerateArchiveLibraryResultPaths,$(NlVersionLibraryDir),$(NlVersionNames))

NlZipDir                        = $(NlSystemDir)/nlzip
NlZipIncludeDirs                = $(NlZipDir)/include
NlZipNames                      = nlzip
NlZipPath                       = $(call GenerateResultPaths,.,$(NlZipDir))
NlZipSrcPath                    = $(BuildRoot)/$(NlZipDir)
NlZipIncludePaths               = $(call GenerateResultPaths,.,$(NlZipIncludeDirs))
NlZipLibraryPaths               = $(call GenerateResultPaths,$(NlZipDir),$(NlZipNames))
NlZipDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(NlZipDir),$(NlZipNames))

NlTlvDir                        = $(FpsDir)/nltlv
NlTlvIncludeDirs                = include
NlTlvLibraryDir                 =
NlTlvName                       = nltlv
NlTlvSrcPath                    = $(BuildRoot)/$(NlTlvDir)
NlTlvIncludePaths               = $(BuildRoot)/$(NlTlvDir)/$(NlTlvIncludeDirs)
NlTlvLibraryPaths               = $(call GenerateResultPaths,$(NlTlvDir),$(NlTlvName))
NlTlvDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(NlTlvDir)/$(NlTlvLibraryDir),$(NlTlvName))

NlIoDir                         = $(FpsDir)/nlio
NlIoIncludeDir                  = $(NlIoDir)/include
NlIoLibraryDir                  = $(NlIoDir)
NlIoNames                       =
NlIoSrcPath                     = $(BuildRoot)/$(NlIoDir)
NlIoPath                        = $(call GenerateResultPaths,.,$(NlIoDir))
NlIoIncludePaths                = $(call GenerateResultPaths,.,$(NlIoIncludeDir))
NlIoLibraryPaths                =
NlIoDependPaths                 =

NlUtilitiesDir                  = $(TpsDir)/nlutilities
NlUtilitiesIncludeDir           = $(NlUtilitiesDir)/include
NlUtilitiesLibraryDir           = $(NlUtilitiesDir)/lib
NlUtilitiesNames                = nlutilities
NlUtilitiesSrcPath              = $(BuildRoot)/$(NlUtilitiesDir)
NlUtilitiesPath                 = $(call GenerateResultPaths,.,$(NlUtilitiesDir))
NlUtilitiesIncludePaths         = $(call GenerateResultPaths,.,$(NlUtilitiesIncludeDir))
NlUtilitiesLibraryPaths         = $(call GenerateResultPaths,$(NlUtilitiesLibraryDir),$(NlUtilitiesNames))
NlUtilitiesDependPaths          = $(call GenerateArchiveLibraryResultPaths,$(NlUtilitiesLibraryDir),$(NlUtilitiesNames))

NlWirelessCalDir                = $(FpsDir)/nlwirelesscal
NlWirelessCalIncludeDirs        = $(NlWirelessCalDir)/include
NlWirelessCalLibraryDir         = $(NlWirelessCalDir)
NlWirelessCalNames              = nlwirelesscal
NlWirelessCalPath               = $(call GenerateResultPaths,.,$(NlWirelessCalDir))
NlWirelessCalIncludePaths       = $(call GenerateResultPaths,.,$(NlWirelessCalIncludeDirs))
NlWirelessCalIncludePath        = $(NlWirelessCalIncludePaths)
NlWirelessCalLibraryPaths       = $(call GenerateResultPaths,$(NlWirelessCalLibraryDir),$(NlWirelessCalNames))
NlWirelessCalDependPaths        = $(call GenerateArchiveLibraryResultPaths,$(NlWirelessCalLibraryDir),$(NlWirelessCalNames))

TestFrameworkDir                = $(FpsDir)/nl-unit-test
TestFrameworkIncludeDirs        = $(TestFrameworkDir)/include
TestFrameworkLibraryDir         = $(TestFrameworkDir)/lib
TestFrameworkNames              = nlunittest
TestFrameworkSrcPath            = $(BuildRoot)/$(TestFrameworkDir)
TestFrameworkPath               = $(call GenerateResultPaths,.,$(TestFrameworkDir))
TestFrameworkIncludePaths       = $(call GenerateResultPaths,.,$(TestFrameworkIncludeDirs))
TestFrameworkLibraryPaths       = $(call GenerateResultPaths,$(TestFrameworkLibraryDir),$(TestFrameworkNames))
TestFrameworkDependPaths        = $(call GenerateArchiveLibraryResultPaths,$(TestFrameworkLibraryDir),$(TestFrameworkNames))

TVDCodeGenDir                   = $(FpsDir)/tvdcodegen

ThciDir                         = $(FpsDir)/thci
ThciIncludeDir                  = include
ThciLibraryDir                  =
ThciName                        = thci
ThciSrcPath                     = $(BuildRoot)/$(ThciDir)
ThciIncludePaths                = $(BuildRoot)/$(ThciDir)/$(ThciIncludeDir)
ThciLibraryPaths                = $(call GenerateResultPaths,$(ThciDir),$(ThciName))
ThciDependPaths                 = $(call GenerateArchiveLibraryResultPaths,$(ThciDir)/$(ThciLibraryDir),$(ThciName))

OpenThreadDir                   = $(TpsDir)/openthread
OpenThreadIncludeDirs           = include
OpenThreadLibraryDir            = $(OpenThreadDir)/lib
OpenThreadPath                  = $(call GenerateResultPaths,.,$(OpenThreadDir))
OpenThreadSrcPath               = $(BuildRoot)/$(OpenThreadDir)
OpenThreadIncludePaths          = $(call GenerateResultPaths,$(OpenThreadDir),$(OpenThreadIncludeDirs))

OpenThreadCliFtdNames           = openthread-cli-ftd
OpenThreadCliFtdLibraryPaths    = $(call GenerateResultPaths,$(OpenThreadLibraryDir),$(OpenThreadCliFtdNames))
OpenThreadCliFtdDependPaths     = $(call GenerateArchiveLibraryResultPaths,$(OpenThreadLibraryDir),$(OpenThreadCliFtdNames))
OpenThreadCliMtdNames           = openthread-cli-mtd
OpenThreadCliMtdLibraryPaths    = $(call GenerateResultPaths,$(OpenThreadLibraryDir),$(OpenThreadCliMtdNames))
OpenThreadCliMtdDependPaths     = $(call GenerateArchiveLibraryResultPaths,$(OpenThreadLibraryDir),$(OpenThreadCliMtdNames))
OpenThreadDiagNames             = openthread-diag
OpenThreadDiagLibraryPaths      = $(call GenerateResultPaths,$(OpenThreadLibraryDir),$(OpenThreadDiagNames))
OpenThreadDiagDependPaths       = $(call GenerateArchiveLibraryResultPaths,$(OpenThreadLibraryDir),$(OpenThreadDiagNames))
OpenThreadFtdNames              = openthread-ftd
OpenThreadFtdLibraryPaths       = $(call GenerateResultPaths,$(OpenThreadLibraryDir),$(OpenThreadFtdNames))
OpenThreadFtdDependPaths        = $(call GenerateArchiveLibraryResultPaths,$(OpenThreadLibraryDir),$(OpenThreadFtdNames))
OpenThreadMbedCryptoNames       = mbedcrypto
OpenThreadMbedCryptoLibraryPaths = $(call GenerateResultPaths,$(OpenThreadLibraryDir),$(OpenThreadMbedCryptoNames))
OpenThreadMbedCryptoDependPaths = $(call GenerateArchiveLibraryResultPaths,$(OpenThreadLibraryDir),$(OpenThreadMbedCryptoNames))
OpenThreadMtdNames              = openthread-mtd
OpenThreadMtdLibraryPaths       = $(call GenerateResultPaths,$(OpenThreadLibraryDir),$(OpenThreadMtdNames))
OpenThreadMtdDependPaths        = $(call GenerateArchiveLibraryResultPaths,$(OpenThreadLibraryDir),$(OpenThreadMtdNames))
OpenThreadNcpFtdNames           = openthread-ncp-ftd
OpenThreadNcpFtdLibraryPaths    = $(call GenerateResultPaths,$(OpenThreadLibraryDir),$(OpenThreadNcpFtdNames))
OpenThreadNcpFtdDependPaths     = $(call GenerateArchiveLibraryResultPaths,$(OpenThreadLibraryDir),$(OpenThreadNcpFtdNames))
OpenThreadNcpMtdNames           = openthread-ncp-mtd
OpenThreadNcpMtdLibraryPaths    = $(call GenerateResultPaths,$(OpenThreadLibraryDir),$(OpenThreadNcpMtdNames))
OpenThreadNcpMtdDependPaths     = $(call GenerateArchiveLibraryResultPaths,$(OpenThreadLibraryDir),$(OpenThreadNcpMtdNames))

OsmDir                          = $(FpsDir)/osm/target
OsmIncludeDirs                  = include \
                                  lib/Applicability/include \
                                  lib/Image/include \
                                  lib/Installation/include \
                                  lib/IntentLogData/include \
                                  lib/Signature/include \
                                  lib/Source/include
OsmNames                        = Osm
OsmTopIncludePaths              = $(BuildRoot)/$(FpsDir)/osm/include
OsmIncludePaths                 = $(call GenerateResultPaths,$(OsmDir),$(OsmIncludeDirs))
OsmLibraryPaths                 = $(call GenerateResultPaths,$(OsmDir),$(OsmNames))
OsmDependPaths                  = $(call GenerateArchiveLibraryResultPaths,$(OsmDir),$(OsmNames))

OsmHostDir 						= $(FpsDir)/osm/host
OsmHostSrcPath 					= $(FpsSrcPath)/osm/host

ImageToolName                   = ImageTool
ImageToolDir                    = $(FpsDir)/imagetool

NlWeaveDir                      = $(FpsDir)/weave
NlWeaveIncludeDirs              = $(NlWeaveDir)/include \
                                  $(NlWeaveDir)/include/Weave \
                                  $(NlWeaveDir)/include/Weave/Core \
                                  $(NlWeaveDir)/include/Weave/Profiles \
                                  $(NlWeaveDir)/include/Weave/Support
NlWeaveSrcPath                  = $(BuildRoot)/$(NlWeaveDir)
NlWeaveLibraryDir               = $(NlWeaveDir)/lib
NlWeaveNames                    = Weave
NlWeavePath                     = $(call GenerateResultPaths,.,$(NlWeaveDir))
NlWeaveIncludePaths             = $(call GenerateResultPaths,.,$(NlWeaveIncludeDirs))
NlWeaveLibraryPaths             = $(call GenerateResultPaths,$(NlWeaveLibraryDir),$(NlWeaveNames))
NlWeaveDependPaths              = $(call GenerateArchiveLibraryResultPaths,$(NlWeaveLibraryDir),$(NlWeaveNames))

NlWeaveSystemDir                = $(NlWeaveDir)
NlWeaveSystemIncludeDir         = include
NlWeaveSystemLibraryDir         = lib
NlWeaveSystemName               = SystemLayer
NlWeaveSystemIncludePath        = $(call GenerateResultPaths,$(NlWeaveSystemDir),$(NlWeaveSystemIncludeDir))
NlWeaveSystemLibraryPath        = $(call GenerateResultPaths,$(NlWeaveSystemDir),$(addprefix $(NlWeaveSystemLibraryDir)/,$(NlWeaveSystemName)))
NlWeaveSystemDependPath         = $(call GenerateArchiveLibraryResultPaths,$(NlWeaveSystemDir)/$(NlWeaveSystemLibraryDir),$(NlWeaveSystemName))

NlInetDir                       = $(NlWeaveDir)
NlInetIncludeDir                = include
NlInetLibraryDir                = lib
NlInetName                      = InetLayer
NlInetIncludePath               = $(call GenerateResultPaths,$(NlInetDir),$(NlInetIncludeDir))
NlInetLibraryPath               = $(call GenerateResultPaths,$(NlInetDir),$(addprefix $(NlInetLibraryDir)/,$(NlInetName)))
NlInetDependPath                = $(call GenerateArchiveLibraryResultPaths,$(NlInetDir)/$(NlInetLibraryDir),$(NlInetName))

HelloWeaveAppDir                = $(FpsDir)/sample_apps/helloweave-app
HelloWeaveAppName               = helloweave-app
HelloWeaveAppSrecPath           = $(call GenerateResultPaths,$(HelloWeaveAppDir),$(HelloWeaveAppName)$(ImageSrecSuffix))

# Although WICED is in tps, its Makefile is in PlatformTpsDir
# Here, we just need to pass down the source directory.
BroadcomDir                     = $(TpsDir)/bcm
WicedDir                        = $(BroadcomDir)/wiced
WicedSrcPath                    = $(BuildRoot)/$(WicedDir)

WeaveDeviceManagerDir           = $(NlWeaveDir)
WeaveDeviceManagerIncludeDirs   = $(WeaveDeviceManagerDir)/src/device-manager
WeaveDeviceManagerLibraryDir    = $(WeaveDeviceManagerDir)/lib
WeaveDeviceManagerNames         = WeaveDeviceManager
WeaveDeviceManagerIncludePaths  = $(call GenerateResultPaths,.,$(WeaveDeviceManagerIncludeDirs))
WeaveDeviceManagerLibraryPaths  = $(call GenerateResultPaths,$(WeaveDeviceManagerLibraryDir),$(WeaveDeviceManagerNames))
WeaveDeviceManagerDependPaths   = $(call GenerateArchiveLibraryResultPaths,$(WeaveDeviceManagerLibraryDir),$(WeaveDeviceManagerNames))

RADaemonDir                     = $(NlWeaveDir)
RADaemonIncludeDirs             = $(RADaemonDir)/src/ra-daemon
RADaemonLibraryDir              = $(RADaemonDir)/lib
RADaemonNames                   = RADaemon
RADaemonSrcPath                 = $(BuildRoot)/$(RADaemonDir)
RADaemonPath                    = $(call GenerateResultPaths,.,$(RADaemonDir))
RADaemonIncludePaths            = $(call GenerateResultPaths,.,$(RADaemonIncludeDirs))
RADaemonLibraryPaths            = $(call GenerateResultPaths,$(RADaemonLibraryDir),$(RADaemonNames))
RADaemonDependPaths             = $(call GenerateArchiveLibraryResultPaths,$(RADaemonLibraryDir),$(RADaemonNames))

# TODO: Circular dependency with Weave proper for WeaveMemoryManager.
NlWeavePlatformDir              = $(FpsDir)/nlweave-platform
NlWeavePlatformIncludeDirs      = $(NlWeavePlatformDir)/include
NlWeavePlatformLibraryDir       = $(NlWeavePlatformDir)
NlWeavePlatformNames            = nlweave-platform
NlWeavePlatformSrcPath          = $(BuildRoot)/$(NlWeavePlatformDir)
NlWeavePlatformPath             = $(call GenerateResultPaths,.,$(NlWeavePlatformDir))
NlWeavePlatformIncludePaths     = $(addprefix $(BuildRoot)/,$(NlWeavePlatformIncludeDirs))
NlWeavePlatformLibraryPaths     = $(call GenerateResultPaths,$(NlWeavePlatformLibraryDir),$(NlWeavePlatformNames))
NlWeavePlatformDependPaths      = $(call GenerateArchiveLibraryResultPaths,$(NlWeavePlatformLibraryDir),$(NlWeavePlatformNames))

NlWirelessRegDir                = $(FpsDir)/nlwirelessreg
NlWirelessRegIncludeDirs        = $(NlWirelessRegDir)/include
NlWirelessRegLibraryDir         = $(NlWirelessRegDir)
NlWirelessRegNames              = nlwirelessreg
NlWirelessRegSrcPath            = $(BuildRoot)/$(NlWirelessRegDir)
NlWirelessRegPath               = $(call GenerateResultPaths,.,$(NlWirelessRegDir))
NlWirelessRegIncludePaths       = $(call GenerateResultPaths,.,$(NlWirelessRegIncludeDirs))
NlWirelessRegIncludePath        = $(addprefix $(BuildRoot)/,$(NlWirelessRegIncludeDirs))
NlWirelessRegLibraryPaths       = $(call GenerateResultPaths,$(NlWirelessRegLibraryDir),$(NlWirelessRegNames))
NlWirelessRegDependPaths        = $(call GenerateArchiveLibraryResultPaths,$(NlWirelessRegLibraryDir),$(NlWirelessRegNames))

MicroECCIncludeDirs             = $(NlWeaveDir)/include/micro-ecc
MicroECCLibraryDir              = $(NlWeaveLibraryDir)
MicroECCNames                   = uECC
MicroECCIncludePaths            = $(call GenerateResultPaths,.,$(MicroECCIncludeDirs))
MicroECCSrcPath            		= $(BuildRoot)/$(NlWeaveDir)/third_party/micro-ecc/micro-ecc
MicroECCLibraryPaths            = $(call GenerateResultPaths,$(NlWeaveLibraryDir),$(MicroECCNames))
MicroECCDependPaths             = $(call GenerateArchiveLibraryResultPaths,$(NlWeaveLibraryDir),$(MicroECCNames))

Sha256IncludeDirs               = $(NlWeaveDir)/include/mincrypt
Sha256LibraryDir                = $(NlWeaveLibraryDir)
Sha256Names                     = mincrypt
Sha256IncludePaths              = $(call GenerateResultPaths,.,$(Sha256IncludeDirs))
Sha256SrcPath					= $(BuildRoot)/$(NlWeaveDir)/third_party/android/platform-system/core-mincrypt/libmincrypt
Sha256LibraryPaths              = $(call GenerateResultPaths,$(NlWeaveLibraryDir),$(Sha256Names))
Sha256DependPaths               = $(call GenerateArchiveLibraryResultPaths,$(NlWeaveLibraryDir),$(Sha256Names))

NlBootloaderDir                        = $(FpsDir)/nlbootloader
NlBootloaderIncludeDirs                = $(NlBootloaderDir)/include
NlBootloaderNames                      = nlbootloader
NlBootloaderPath                       = $(call GenerateResultPaths,.,$(NlBootloaderDir))
NlBootloaderSrcPath                    = $(BuildRoot)/$(NlBootloaderDir)
NlBootloaderIncludePaths               = $(call GenerateResultPaths,.,$(NlBootloaderIncludeDirs))
NlBootloaderLibraryPaths               = $(call GenerateResultPaths,$(NlBootloaderDir),$(NlBootloaderNames))
NlBootloaderDependPaths                = $(call GenerateArchiveLibraryResultPaths,$(NlBootloaderDir),$(NlBootloaderNames))

NlCryptoVectorDir                    = $(FpsDir)/nlbootloader
NlCryptoVectorIncludeDirs            = $(NlCryptoVectorDir)/include
NlCryptoVectorNames                  = nlcrypto_vector
NlCryptoVectorPath                   = $(call GenerateResultPaths,.,$(NlCryptoVectorDir))
NlCryptoVectorSrcPath                = $(BuildRoot)/$(NlCryptoVectorDir)
NlCryptoVectorIncludePaths           = $(call GenerateResultPaths,.,$(NlCryptoVectorIncludeDirs))
NlCryptoVectorLibraryPaths           = $(call GenerateResultPaths,$(NlCryptoVectorDir),$(NlCryptoVectorNames))
NlCryptoVectorDependPaths            = $(call GenerateArchiveLibraryResultPaths,$(NlCryptoVectorDir),$(NlCryptoVectorNames))

PRETTY_CHECK                         = $(PERL) $(BuildRoot)/build/third_party/cstyle/repo/cstyle.pl
ifndef PRETTY_CHECK_ARGS
export PRETTY_CHECK_ARGS            := $(shell cat $(BuildRoot)/build/third_party/cstyle/cstyle.options)
endif
