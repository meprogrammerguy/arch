#!/bin/bash
args="-v"
cd $HOME
echo "***"
echo "*** moving config files to git ***"
echo "***"
cp $args $HOME/.config/zsh/config.d/zsh.conf $HOME/git/arch/zsh/config.d/zsh.conf
cp $args $HOME/.vimrc $HOME/git/arch/vim/.vimrc
cp $args $HOME/.sh/* $HOME/git/arch/sh/
cp $args $HOME/.config/foot/* $HOME/git/arch/foot/
cp $args $HOME/.config/profile.d/* $HOME/git/arch/profile.d/
cp $args $HOME/.config/rofi/* $HOME/git/arch/rofi/
cp $args $HOME/.config/sway/config $HOME/git/arch/sway/config
cp $args $HOME/.config/sway/dark-wood.jpg $HOME/git/arch/sway/dark-wood.jpg 
cp $args $HOME/.config/sway/definitions.d/* $HOME/git/arch/sway/definitions.d/
cp $args $HOME/.config/sway/config.d/* $HOME/git/arch/sway/config.d/
cp $args $HOME/.config/sworkstyle/config.toml $HOME/git/arch/sworkstyle/config.toml
cp $args $HOME/.config/waybar/* $HOME/git/arch/waybar/
cp $args $HOME/.config/way-displays/cfg.yaml $HOME/git/arch/way-displays/cfg.yaml
cp $args $HOME/.config/wluma/config.toml $HOME/git/arch/wluma/config.toml
cp $args $HOME/git/toolchain/manjaro/plans.txt $HOME/git/arch/todo/plans.txt
cp $args $HOME/git/toolchain/manjaro/notes.txt $HOME/git/arch/todo/notes.txt
cd $HOME/git/arch
git add -A
git commit -m "update latest setting files"
git push -v