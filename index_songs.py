#!/usr/bin/env python3

import mutagen
import glob
import json
import sys

id_to_file = {}
base_path=""
if len(sys.argv) == 2
    base_path = sys.argv[1]
else:
    print("Pass the path to your music collection to this script")
    sys.exit(-22)
for file in glob.glob(base_path + "/*.mp3", recursive=True):
    try:
        taginfo = mutagen.File(file)
        if taginfo is not None:
                mbid = taginfo["TXXX:MusicBrainz Release Track Id"].text[0]
                print(mbid)
                if mbid is not None:
                    id_to_file[mbid] = file
    except:
        continue

for file in glob.glob("*.flac", recursive=True):
    try:
        taginfo = mutagen.File(file)
        if taginfo is not None:
                mbid = taginfo["musicbrainz_trackid"][0]
                print(mbid)
                if mbid is not None:
                    id_to_file[mbid] = file
    except:
        continue

with open("file_index.json", "w") as f:
    f.write(json.dumps(id_to_file))
