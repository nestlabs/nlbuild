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

#
#    Description:
#      This file establishes the minimum environment, under the C
#      (csh) or Tenon C (tcsh) shells, for running a build of the tree
#      containing this script.
#
#      This script MUST BE sourced from a current working directory
#      within the tree.
#

# Assuming that the user has complied with the requirement to source
# this script from a working directory within the tree, attempt to
# find a directory of the form '.../build/scripts/environment/'.

setenv BuildRoot

set current = "`/bin/pwd -P`"
set last = ""

# Try to find a valid root match until we are no longer making forward
# progress and have reached the top of the directory tree.

while ( "${current}" != "${last}" )

    # Check to see if the directory is a root match and if so, leave
    # with successful status.

    if ( -d "${current}"/build/scripts/environment ) then
	setenv BuildRoot "${current}"
	break	
    endif

    # If there was no match, save the current directory, and prune off
    # a piece of the path to try again.

    set last = "${current}"
    set current = `dirname "${last}"`
end

unset current
unset last

if ( z"${BuildRoot}" == "z" ) then
    echo "Could not establish a root directory for this project above '`pwd`'! This script must be sourced from WITHIN the project tree."
    unsetenv BuildRoot
    exit 1
endif

# Set-up the make flags. We use the following:
#
# --no-print-directory  Do not print 'make[n]: ...' as make traverses
#                       directories.
#
# -r			No built-in rules. We have our own, thank you, and do
#                       not want any side effects for what just so happens to
#                       work for Solaris, Linux, Mac OS X, System V, BSD, etc.
#
# -R			No built-in variables. We have our own, thank you, and
#                       do not want any side effects for what just so happens
#                       to work for Solaris, Linux, Mac OS X, System V, BSD,
#                       etc.
#
# -I <path>		Location where make can find make include files. We
#                       adopt this approach since one of the goals of this
#                       build environment is making make files sparse. Doing
#			otherwise would require '${BuildRoot}/build/make/
#			<foo>.mak' instead of 'include <foo>.mak', a lot of
#                       extra typing for a project tree's worth of make files.
#

setenv MAKEFLAGS "--no-print-directory -r -R -I ${BuildRoot}/build/make"

# Users can create both build-global and -local
# additional/overriding environment information.

set BuildGlobalEnvironment = "${HOME}/.buildrc"
set BuildLocalEnvironment = "${BuildRoot}/build/${USER}/buildrc"

# Try the build-global file

if ( -r "${BuildGlobalEnvironment}" ) then
    source "${BuildGlobalEnvironment}"
endif

# Try the build-local file

if ( -r "${BuildLocalEnvironment}" ) then
    source "${BuildLocalEnvironment}"
endif

# Clean-up any variables we have set

unset BuildGlobalEnvironment
unset BuildLocalEnvironment

# Display to the user how we configured the build environment.

${BuildRoot}/build/scripts/printenv

# Check if repo exists and if so, does some setup of repositories
which repo > /dev/null
if ( $? == 1 ) then
    echo "Skipping steps for repo"
else
    # Make sure the .git/info/exclude file of every subproject excludes .build and .depend folders
    # This is less invasive than trying to touch an existing .gitignore file
    repo forall -c 'echo "making sure *.build is in $REPO_PATH/.git/info/exclude" ; if grep -q "*\.build" .git/info/exclude; then echo "already present"; else echo "*.build" >> .git/info/exclude; fi'
    repo forall -c 'echo "making sure *.depend is in $REPO_PATH/.git/info/exclude" ; if grep -q "*\.depend" .git/info/exclude; then echo "already present"; else echo "*.depend" >> .git/info/exclude; fi'

    # function for running git status in every repository.  It can be better than "repo status"
    # because repo status shows every file but "git status" will show just a directory
    # as being unknown so can be a better summary
    alias rags 'repo forall -c '"'"'echo "calling git status in $REPO_PATH:" ; git status -s'"'"''

    # function for running git log --oneline $REPO_REMOTE/$REMO_RREV..HEAD in every repository.
    # It helps show changes you have committed in the local branch but have not
    # pushed to the remote repository defined in the manifest.

    alias radelta 'repo forall -c '"'"'echo "calling git log --oneline $REPO_REMOTE/$REPO_RREV..HEAD in $REPO_PATH:" ; git log --oneline $REPO_REMOTE/$REPO_RREV..HEAD'"'"''
endif
