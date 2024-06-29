#!/bin/bash
#
# movie chopping/convert tool for usb dvd player
#

for f in "$@"
do
    name=$(basename "$f")
    dir=$(dirname "$f")
    /opt/local/bin/ffmpeg -i "$f" -b 250k -strict experimental -deinterlace -vcodec h264 -acodec aac "$dir/mp4/${name%.*}.mp4"
    echo "$dir/mp4/${name%.*}.mp4"
done

# ffmpeg -i myvideo 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//
#       gives length use to decide on last file (re-run it to be slightly more than 30 min 
