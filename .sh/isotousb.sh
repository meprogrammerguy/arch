#!/bin/bash
#
# iso to usb tool
#

log_file="$HOME/.tmp/iso-to-usb.log"
title="ISO-to-USB-tool"
default_dir="$HOME/.usb-images/"
echo " " > $log_file
echo "              $title" >> $log_file
echo " " >> $log_file
echo " " >> $log_file
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "start: $dt" >> $log_file
echo " " >> $log_file
icon="$HOME/.config/icons/my_avatar.ico"
echo " " >> $log_file
lsblk >> $log_file
if [[ -z $(lsblk | grep sda) ]]
then
    echo "There is no USB drive mounted,  quitting..." >> $log_file
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "*** end: $dt ***" >> $log_file
    notify-send -i $icon "There is no USB drive mounted" "quitting"
    exit 1
fi
the_iso=$(yad --title=$title --text="enter your ISO file name" --text-align=center --file --filename="$default_dir")
if [[ -z $the_iso ]]
then
    echo "user has cancelled from ISO choice screen,  quitting..." >> $log_file
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "*** end: $dt ***" >> $log_file
    notify-send -i $icon "$title" "user has cancelled"
    exit 1
fi
echo " " >> $log_file
echo "============================================================================================" >> $log_file
echo "ISO file to burn: $the_iso" >> $log_file 
usb_label=$(lsblk | grep sda1 | sed 's|.*/||')
echo "the USB is mounted with label: $usb_label" >> $log_file
echo "============================================================================================" >> $log_file

yad --text-info --text-align=center --title=$title --text="Do you want to continue?" --filename=$log_file
yad_button=$?
if [[ $yad_button -gt 0 ]]
then
    echo "user has cancelled from final confirm screen,  quitting..." >> $log_file
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "*** end: $dt ***" >> $log_file
    notify-send -i $icon "$title" "user has cancelled"
    exit 1
fi
echo "unmounting /dev/disk/by-label/$usb_label" >> $log_file
sudo umount "/dev/disk/by-label/$usb_label"
sudo dd bs=4M if=$the_iso of=/dev/sda status=progress oflag=sync
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "*** end: $dt success ***" >> $log_file
notify-send -i $icon "$title" "SUCCESS"
