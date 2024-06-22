#!/bin/bash
icon="/usr/share/icons/Dracula/24/actions/flag-green.svg"
if [[ $(lsblk | grep sda1) ]]
then
    umount -q -f /dev/sda1
fi
if [[ $(lsblk | grep sda1) ]]
then
    sudo umount -q -f /dev/sda1
fi
sudo mkfs.vfat /dev/sda1 -n MOVIE
umount -q -f /dev/sda1
notify-send -i $icon "USB format:" "SUCCESS"
if [[ $(lsblk | grep sda1) ]]
then
    sudo umount -q -f /dev/sda1
fi
