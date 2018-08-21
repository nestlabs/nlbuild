#!/usr/bin/env python

#
#    Copyright (c) 2013-2018 Nest Labs, Inc.
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


import sys
from nestlabs.event import EventDescriptor
import pickle
import os
import fnmatch
import filecmp

all_files = dict()
all_hashes = dict()

print sys.argv[0]
print sys.argv[1]   # build directory
print sys.argv[2]   # breadcrumbs path
print sys.argv[3]   # host tools path
print sys.argv[4]   # subdirectories with breadcrumb files

# Subdirectories with breadcrumbs:
subdirectories = sys.argv[4].split()
# Subdirectories that should be ignored/skipped in search for breadcrumbs
skip_directories = ['.git', '.build', '.depend']

for subdirectory in subdirectories:
    breadcrumb_files = []
    for root, dirnames, filenames in os.walk(subdirectory, followlinks=True):
        # print "root: %s" % root
        # remove subdirectories that we shouldn't search
        for skip_dir in skip_directories:
            if skip_dir in dirnames: dirnames.remove(skip_dir)
        for fname in fnmatch.filter(filenames, '*.breadcrumbs'):
            full_fname_path = os.path.join(root,fname)
            execfile(full_fname_path)
            all_events = []

            # see if .build folder has been created.  if it hasn't, skip processing
            # the breadcrumb file because it's not in the build
            if  os.path.exists(full_fname_path[:(full_fname_path.rfind("/")+1)]+sys.argv[1]) == False:
                print full_fname_path[:(full_fname_path.rfind("/")+1)]+sys.argv[1]+" not found!\n"
                continue

            # add to global all_events, error out if duplicate found
            for ev in events.get_events_list():
                new_event = EventDescriptor(fname, ev.get_name(), ev.get_params(), ev.get_description())
                print "new_event.filename: %s new_event.name: %s checksum %s" % (new_event.filename, new_event.name, new_event.cksum())
                if new_event.cksum() in all_hashes:
                    print "Error: %s %s checksum %s already present" % (new_event.filename, new_event.name, new_event.cksum())
                    sys.exit(-1)
                all_events.append(new_event)
                all_hashes[new_event.cksum()] = new_event
            all_files[fname] = all_events

            localFilePath = full_fname_path[:(full_fname_path.rfind("/")+1)]+sys.argv[1]+"/nlbreadcrumbs-local.h"
            localTmpFilePath = full_fname_path[:(full_fname_path.rfind("/")+1)]+sys.argv[1]+"/nlbreadcrumbs-local.h.tmp"

            pm_local_h = list()

            pm_local_h = open(localTmpFilePath, 'w')
            for ev in all_events:
                pm_local_h.write(ev.get_macro(2))

            pm_local_h.close()
            if (os.path.exists(localFilePath) == False) or filecmp.cmp(localTmpFilePath, localFilePath) == False:
                print "Created new file " + localFilePath
                os.rename(localTmpFilePath, localFilePath)
            else:
                print "Using previously generated " + localFilePath
                os.remove(localTmpFilePath)

# Create nlbreadcrumbs-all.h.tmp
breadcrumbsFilePath = "%s/nlbreadcrumbs-all.h" % sys.argv[2]
breadcrumbsTmpFilePath = "%s/nlbreadcrumbs-all.h.tmp" % sys.argv[2]
with open(breadcrumbsTmpFilePath, "w") as pm_events_h:
    for one_script in all_files.values():
        indent = 0

        pm_events_h.write("%s// From file: %s\n" % ("  "*indent, one_script[0].filename))
        print "\nEVENTS"
        for ev in one_script:
            print "%s | %s %s" % (ev.cksum(), ev.filename, ev.name)
            pm_events_h.write("%sstatic const uint32_t  k%s=0x%sul;\n" % ("  "*indent, ev.name, ev.cksum()))
        pm_events_h.write("\n")
        print ""
        indent -= 1

# If no previous nlbreadcrumbs-all.h, rename nlbreadcrumbs-all.h.tmp to nlbreadcrumbs-all.h.
# If file exists, compare the new one to the old one.  If the same, just delete the
# tmp file.  If they are not the same, mv the new one over the old one.
# This way, if nothing has changed, source files that include nlbreadcrumbs-all.h
# won't get forced to recompile for no reason.
if (os.path.exists(breadcrumbsFilePath) == False) or (filecmp.cmp(breadcrumbsTmpFilePath, breadcrumbsFilePath) == False):
    print "Created new file " + breadcrumbsFilePath
    os.rename(breadcrumbsTmpFilePath, breadcrumbsFilePath)
else:
    print "Using previous generated " + breadcrumbsFilePath
    os.remove(breadcrumbsTmpFilePath)

with open("%s/breadcrumbs-db" % sys.argv[3], "w") as dbfile:
    pickle.dump(all_hashes,dbfile)
