#!/bin/bash
args="-v -i"
cd $HOME
echo "***"
echo "*** moving config files to git ***"
echo "***"
cp $args $HOME/.config/zsh/config.d/zsh.conf $HOME/git/arch/zsh/config.d/zsh.conf
cp $args $HOME/.vimrc $HOME/git/arch/vim/.vimrc
cp $args $HOME/.sh/* $HOME/git/arch/sh/
cd $HOME/git/arch
git add -A
git commit -m "update latest setting files"
git push