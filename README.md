# OpenPlaylister

A free and open source AI-driven playlist generator that learns your listening
habits and can be run on local music files.

Think of it as a streaming service playlist recommendation algorithm that runs
on a local file-based music collection.

## Scripts 
`preprocess.sh` - processes a listenbrainz json into a sequence of track ids which we will use as tokens for our seq2seq ai
`train.sh` - trains the ai model to recognize sequence patterns in your listening history
`generate.sh` - runs inference on the ai model (outputs new sequences of track ids which will become our playlists
`index_songs.py` - associates musicbrainz track ids to local files
`write_playlist.py` - parses the output of generate.sh and produces an m3u playlist file using the file index

## How to use
- create a python virutalenv and install requirements.txt
- Track or import your listening history using https://listenbrainz.org
- export your listening history as a json file https://listenbrainz.org/settings/export/
- run preprocess.sh on your json file
- train the model using train.sh
- use musicbrainz picard to write musicbrainz id3 tags to your local music collection https://picard.musicbrainz.org/
- use `index_songs.py` to read these id3 tags and map ids to local files
- run `./generate.sh | ./write_playlist.py` to generate an m3u playlist file
-- it will ask  for an "input sentence", put some musicbrainz ids here to start the playlist off with
- open the m3u file using your music player


## Note
Currently this will always produce the same output for a given input.
Which is not ideal for a playlist generator. I'll try to see if I can
spice things up a bit in future commits.
