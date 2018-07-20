#!/bin/bash


# The purpose of this script is to play all files in the current working
# directory (CWD) and all directories below. The motivation for creating this
# was that at the moment VLC's play-all-files-in-directory doesn't work for some
# reason and that's the way I always use VLC: to play all files in a directory.


# Create playlist to tmp
playlist=`mktemp --suffix=.m3u`
# Playlist was created to /tmp because otherwise `find` would find it and add it
# to playlist. The video file extensions list is from VLC source code.
find . -type f \( \
    -iname \*.3g2 \
    -o -iname \*.3gp \
    -o -iname \*.3gp2 \
    -o -iname \*.3gpp \
    -o -iname \*.amv \
    -o -iname \*.asf \
    -o -iname \*.avi \
    -o -iname \*.bik \
    -o -iname \*.divx \
    -o -iname \*.drc \
    -o -iname \*.dv \
    -o -iname \*.f4v \
    -o -iname \*.flv \
    -o -iname \*.gvi \
    -o -iname \*.gxf \
    -o -iname \*.m1v \
    -o -iname \*.m2t \
    -o -iname \*.m2ts \
    -o -iname \*.m2v \
    -o -iname \*.m4v \
    -o -iname \*.mkv \
    -o -iname \*.mov \
    -o -iname \*.mp2v \
    -o -iname \*.mp4 \
    -o -iname \*.mp4v \
    -o -iname \*.mpa \
    -o -iname \*.mpe \
    -o -iname \*.mpeg \
    -o -iname \*.mpeg1 \
    -o -iname \*.mpeg2 \
    -o -iname \*.mpeg4 \
    -o -iname \*.mpg \
    -o -iname \*.mpv2 \
    -o -iname \*.mts \
    -o -iname \*.mtv \
    -o -iname \*.mxf \
    -o -iname \*.nsv \
    -o -iname \*.nuv \
    -o -iname \*.ogg \
    -o -iname \*.ogm \
    -o -iname \*.ogv \
    -o -iname \*.ogx \
    -o -iname \*.rec \
    -o -iname \*.rm \
    -o -iname \*.rmvb \
    -o -iname \*.rpl \
    -o -iname \*.thp \
    -o -iname \*.tod \
    -o -iname \*.ts \
    -o -iname \*.tts \
    -o -iname \*.vob \
    -o -iname \*.vro \
    -o -iname \*.webm \
    -o -iname \*.wmv \
    -o -iname \*.xesc \) > $playlist

# Randomize playlist if requested
# The parentheses are not strictly speaking necessary
if [ $# -gt 0 ] && ( [ "$1" == "-r" ] || [ "$1" == "--random" ] )
then
    randParam=-R
else
    randParam=""
fi
sort $randParam -o $playlist $playlist

# Move playlist to CWD because otherwise the relative file paths wouldn't be
# valid.
mv $playlist .
# Convert the absolute filepath to a relative one
playlistfilen=`basename $playlist`

outf=`mktemp`
vlc $playlistfilen > $outf 2>&1
rm $playlistfilen $outf
