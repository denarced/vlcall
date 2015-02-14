#!/bin/bash


# The purpose of this script is to play all files in the current working
# directory (CWD) and all directories below. The motivation for creating this
# was that at the moment VLC's play-all-files-in-directory doesn't work for some
# reason and that's the way I always use VLC: to play all files in a directory.


# Create playlist to tmp
playlist=`mktemp --suffix=.m3u`
# Playlist was created to /tmp because otherwise `find` would find it and add it
# to playlist.
find . -type f | sort > $playlist

# Move playlist to CWD because otherwise the relative file paths wouldn't be
# valid.
mv $playlist .
# Convert the absolute filepath to a relative one
playlistfilen=`basename $playlist`

outf=`mktemp`
vlc $playlistfilen > $outf 2>&1
rm $playlistfilen $outf
