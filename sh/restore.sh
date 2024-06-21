#!/bin/bash
cd $HOME
rmdir -r $HOME/.tmp/restore
mkdir $HOME/.tmp/restore
gocryptfs $HOME/.tmp/backup/ $HOME/.tmp/restore -q --passfile $HOME/.config/mount.conf
