#!/bin/bash
icon="/usr/share/icons/Dracula/22/actions/document-decrypt.svg"
cd $HOME
rm -r -f $HOME/.tmp/restore
mkdir $HOME/.tmp/restore
rm -r -f $HOME/.tmp/backup
mkdir $HOME/.tmp/backup
cp $HOME/jsmith/git/arch/private/* $HOME/.tmp/backup/
gocryptfs $HOME/.tmp/backup/ $HOME/.tmp/restore -q --passfile $HOME/.config/mount.conf
notify-send -i $icon "files decrypted to:" "$HOME/.tmp/backup"
