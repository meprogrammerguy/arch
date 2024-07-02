#!/bin/bash
#
# dvd convert and slice tool
#

# mv -f source target

log_file="$HOME/.tmp/dvd_yad.log"
title="dvd-convert-slice"
default_dir="$HOME/Videos/"
echo " " > $log_file
echo "              $title" >> $log_file
echo " " >> $log_file
echo " " >> $log_file
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "start: $dt" >> $log_file
echo " " >> $log_file
icon="$HOME/.config/icons/my_avatar.ico"
echo " " >> $log_file
the_dvd=$(yad --title=$title --text="enter video file to convert and slice" --text-align=center --file --filename="$default_dir")
if [[ -z $the_dvd ]]
then
    echo "user has cancelled from the video choice screen,  quitting..." >> $log_file
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "*** end: $dt ***" >> $log_file
    notify-send -i $icon "$title" "user has cancelled"
    exit 1
fi
dvd_dir=$(echo "$the_dvd" | sed 's:/[^/]*$::')
echo " " >> $log_file
echo "============================================================================================" >> $log_file
dvd_file=$(echo "$the_dvd" | sed 's|.*/||')
q_dvd=$(echo '"'$the_dvd'"')
echo "/usr/bin/ffmpeg -i $q_dvd 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//" > $HOME/.tmp/ffmpeg_length.sh
chmod a+x $HOME/.tmp/ffmpeg_length.sh
$HOME/.tmp/ffmpeg_length.sh > $HOME/.tmp/ffmpeg_length.log
file_length=$(cat $HOME/.tmp/ffmpeg_length.log)
slice_array=(${file_length//:/ })
slices=$[slice_array[0]*2]
echo "$slices"
last_slice=$[30+slice_array[1]+1]
echo "$last_slice"
#dvd_type="${dvd_file##*.}"
dvd_name="${dvd_file%.*}.mpg"
echo " " >> $log_file
echo "directory is:         $dvd_dir" >> $log_file
echo " " >> $log_file
echo "file is:              $dvd_file" >> $log_file
echo "File length:          $file_length" >> $log_file
echo "number of slices:     $slices" >> $log_file
echo "last slice length:    $last_slice minutes" >> $log_file
echo " " >> $log_file
echo "template is:          xx-$dvd_name" >> $log_file 
#echo "file type is:         $dvd_type" >> $log_file
echo " " >> $log_file
echo "============================================================================================" >> $log_file

yad --text-info --text-align=center --title=$title --text="continue?" --fore=green --filename=$log_file
yad_button=$?
if [[ $yad_button -gt 0 ]]
then
    echo "user has cancelled from final confirm screen,  quitting..." >> $log_file
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "*** end: $dt ***" >> $log_file
    notify-send -i $icon "$title" "user has cancelled"
    exit 1
fi
counter=0
minutes=0
#while [ 1 ]
#do
    counter=$[counter + 1]
    hours=$[minutes / 60]
    minutes=$[minutes - hours * 60 ]
    time_offset=$(echo "$hours:$minutes:0")
    counter=$(printf "%02d" $counter)
    q_dir=$(echo '"'$default_dir.convert/$counter-$dvd_name'"')
    ffmpeg_info=$(echo /usr/bin/ffmpeg -ss "$time_offset" -y -i\
        "$q_dvd" \
        -f dvd -target ntsc-dvd -b:v 5000k -r 30000/1001 -filter:v scale=720:480 -ar 48000 -b:a 384k   -t 0:30:0\
        "$q_dir")
    echo "$ffmpeg_info" > $HOME/.tmp/ffmpeg_info.sh
    echo "/usr/bin/ffmpeg -i "$q_dir" 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//" >> $HOME/.tmp/ffmpeg_info.sh
    chmod a+x $HOME/.tmp/ffmpeg_info.sh
    cat $HOME/.tmp/ffmpeg_info.sh
    #$HOME/.tmp/ffmpeg_info.sh
    minutes=$[minutes + 30]
#done
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "*** end: $dt ***" >> $log_file
notify-send -i $icon "$title" "SUCCESS"
 