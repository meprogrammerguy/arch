#!/bin/bash
icon="/usr/share/icons/Dracula/22/actions/document-save.svg"
cd $HOME
rm -r -f $HOME/.tmp/backup/
rm -f $HOME/decrypt/private/.gocryptfs.reverse.conf
gocryptfs -q -init -reverse $HOME/decrypt/private --passfile $HOME/.config/mount.conf
mkdir $HOME/.tmp/crypt
gocryptfs -reverse $HOME/decrypt/private $HOME/.tmp/crypt -q --passfile $HOME/.config/mount.conf
cp -a $HOME/.tmp/crypt $HOME/.tmp/backup
fusermount -u $HOME/.tmp/crypt
rm -r -f $HOME/.tmp/crypt
notify-send -i $icon "files backed up to:" "$HOME/.tmp/backup"