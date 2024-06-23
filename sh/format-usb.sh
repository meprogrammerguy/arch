#!/bin/bash
#
# don't use yet, learn more about sfdisk
# https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script
#
icon="/usr/share/icons/Dracula/24/actions/flag-green.svg"
if [[ $(lsblk | grep sda1) ]]
then
    sudo umount -q -f /dev/sda1
fi
if [[ $(lsblk | grep -L sda1) ]]
then
    #/dev/sda1        2048 30719999 30717952 14.6G  c W95 FAT32 (LBA)
    sudo dd if=/dev/zero of=/dev/sda bs=1m
    #sudo dd if=/dev/zero of=/dev/sda1 bs=1M count=14GB status=progress
    sudo mkfs.vfat -v /dev/sda1 -n MOVIE
    sudo umount -q -f /dev/sda1
    notify-send -i $icon "USB format:" "SUCCESS"
else
    notify-send -i $icon "USB format:" "NOPE"
fi
if [[ $(lsblk | grep sda1) ]]
then
    sudo umount -q -f /dev/sda1
fi
