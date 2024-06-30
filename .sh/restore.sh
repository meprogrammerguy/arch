#!/bin/bash
icon="$HOME/.config/icons/my_avatar.ico"
cd $HOME
if [ -d $HOME/.tmp/restore ]; then
    echo "restore directory exists, removing"
    fusermount -u $HOME/.tmp/restore
    rm -r -f $HOME/.tmp/restore
fi
mkdir $HOME/.tmp/restore
if [ -d $HOME/.tmp/backup ]; then
    echo "encrypted directory exists, decrypting"
else
    echo "decrypting from arch repo"
    mkdir $HOME/.tmp/backup
    cp $HOME/git/arch/private/* $HOME/.tmp/backup/
fi
gocryptfs $HOME/.tmp/backup/ $HOME/.tmp/restore -q --passfile $HOME/.config/mount.conf
notify-send -i $icon "files decrypted to:" "$HOME/.tmp/restore"
