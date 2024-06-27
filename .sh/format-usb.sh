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

icon="/usr/share/icons/Dracula/24@2x/places/user-home.svg"

while [ 1 ]
do
    if [[ -z $(lsblk | grep sda) ]]
    then
        read -p "Insert a USB drive: Press any key to continue... "
    else
        break
    fi
done
if [[ $(lsblk | grep ENFAIN) ]]
then
    sudo umount /dev/disk/by-label/ENFAIN
    sudo mkfs.fat -v -F32 /dev/disk/by-label/ENFAIN -n MOVIE
else
    sudo umount /dev/disk/by-label/MOVIE
    sudo mkfs.fat -v -F32 /dev/sda -n MOVIE
fi
notify-send -i $icon "USB format:" "SUCCESS"
