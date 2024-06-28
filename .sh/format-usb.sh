#!/bin/bash
#
# ideas came from:
# https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script
#
# sudo fdsk -l
#   Disk /dev/sda: 14.65 GiB, 15728640000 bytes, 30720000 sectors
#   Disk model: USB 2.0 Classic 
#   Units: sectors of 1 * 512 = 512 bytes
#   Sector size (logical/physical): 512 bytes / 512 bytes
#   I/O size (minimum/optimal): 512 bytes / 512 bytes
#   Disklabel type: dos
#   Disk identifier: 0x5c592eb2

#   Device     Boot Start      End  Sectors  Size Id Type
#   /dev/sda1        2048 30719999 30717952 14.6G  b W95 FAT32
#
new_label="${1:-MOVIE}"
title="USB re-format tool"
options=("insert usb to continue" "quit")
log_file="$HOME/.tmp/format-usb.log"
icon="/usr/share/icons/Dracula/24@2x/places/user-home.svg"
lsblk
if [[ -z $(lsblk | grep sda) ]]
then
    opt=$(yad --no-buttons --text="$title" --list  --column="Options" "${options[@]}");
    if [[ $opt == *"q"* ]];
    then
        notify-send -i $icon "USB format:" "QUIT"
        exit 1
    fi
fi

echo "*** format usb tool ***" > $log_file
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "*** start: $dt ***" >> $log_file
lsblk >> $log_file
usb_label=$(lsblk | grep sda1 | sed 's|.*/||')
if [[ ! -z $usb_label ]]
then
    echo "usb mounted by label: $usb_label" >> $log_file
    sudo umount "/dev/disk/by-label/$usb_label"
    #sudo mkfs.fat -v -F32 "/dev/disk/by-label/$usb_label" -n $new_label
else
    echo "usb drive not mounted, continuing" >> $log_file
    #sudo mkfs.fat -v -F32 /dev/sda1 -n $new_label 
fi
echo "new label is $new_label" >> $log_file
sudo mkfs.fat -v -F32 "/dev/disk/by-label/$usb_label" -n $new_label
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "*** end: $dt ***" >> $log_file
notify-send -i $icon "USB format:" "SUCCESS"
# *** figure out this stuff
#  lsblk
#
#   sudo mkfs.fat -v -F32 /dev/disk/by-label/MOVIE -n MOVIE
#   sudo mkfs.fat -v -F32 /dev/sda -n MOVIE  <==
#   sudo mkfs.fat -v -F32 /dev/sda1 -n MOVIE  
#
#   sudo dd if=/dev/zero of=/dev/sda bs=1M status=progress oflag=sync 1)
#   sudo dd if=/dev/zero of=/dev/sda1 bs=1M status=progress oflag=sync
#   sudo dd if=/dev/zero of=/dev/sda2 bs=1M status=progress oflag=sync 2)
# ***
