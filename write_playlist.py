#!/usr/bin/env python3

import json
import sys
import uuid

from collections import OrderedDict

indexmap = json.load(open("file_index.json", "rb"))

#print(indexmap)

inp = sys.stdin.read()

mbids = []

inp = inp[inp.find("D-0"):inp.find("P-0")]

for word in inp.split(" "):
    try:
        # there's lots of other junk in the output 
        # and we only want the uuids
        #print(word)
        mbid = uuid.UUID(word)
        #print(mbid)
        mbids.append(str(mbid))
    except Exception as e:
        print(e)
        continue

# remove duplicates while maintaining order
mbids = list(OrderedDict.fromkeys(mbids))

with open("playlist.m3u", "w") as f:
    for mbid in mbids:
        # lookup the file name from the uuid
        #print(mbid)
        try:
            f.write(indexmap[str(mbid)]+"\n")
        except Exception as e:
            # ignore songs not in the index
            #print(e)
            continue
