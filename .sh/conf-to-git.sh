#!/bin/bash
icon="/usr/share/icons/Dracula/22/actions/upload-media.svg"
args="-f "
cd $HOME
cp $args $HOME/.config/zsh/config.d/zsh.conf $HOME/git/arch/zsh/config.d/zsh.conf
cp $args $HOME/.vimrc $HOME/git/arch/vim/.vimrc
cp $args -r $HOME/.sh $HOME/git/arch
cp $args $HOME/.config/foot/* $HOME/git/arch/foot/
cp $args $HOME/.config/profile.d/* $HOME/git/arch/profile.d/
cp -r $args $HOME/.config/rofi $HOME/git/arch
cp $args $HOME/.config/sway/config $HOME/git/arch/sway/config
cp $args $HOME/.config/sway/dark-wood.jpg $HOME/git/arch/sway/dark-wood.jpg 
cp $args $HOME/.config/sway/definitions.d/* $HOME/git/arch/sway/definitions.d/
cp -r $args $HOME/.config/sway/scripts $HOME/git/arch/sway
cp -r $args $HOME/.config/sway/examples $HOME/git/arch/sway
cp -r $args $HOME/.config/wofi-wifi-menu $HOME/git/arch
cp -r $args $HOME/.config/todo $HOME/git/arch/todo
cp $args $HOME/.config/sway/config.d/* $HOME/git/arch/sway/config.d/
cp $args $HOME/.config/sworkstyle/config.toml $HOME/git/arch/sworkstyle/config.toml
cp $args $HOME/.config/waybar/* $HOME/git/arch/waybar/
cp $args $HOME/.config/way-displays/cfg.yaml $HOME/git/arch/way-displays/cfg.yaml
cp $args $HOME/.config/wluma/config.toml $HOME/git/arch/wluma/config.toml
cp $args $HOME/.config/weather.cfg $HOME/git/arch/config/weather.cfg
pacman -Qqe > $HOME/.tmp/pkglist.txt
cp $args $HOME/.tmp/pkglist.txt $HOME/git/arch/packages/pkglist.txt
pacman -Qqem > $HOME/.tmp/foreignpkglist.txt
cp $args $HOME/.tmp/foreignpkglist.txt $HOME/git/arch/packages/foreignpkglist.txt
comm -13 <(pacman -Qqdt | sort) <(pacman -Qqdtt | sort) > $HOME/.tmp/optdeplist.txt
cp $args $HOME/.tmp/optdeplist.txt $HOME/git/arch/packages/optdeplist.txt
# optional can be reinstalled with "--asdeps"
rm -r -f $HOME/git/arch/private
mkdir $HOME/git/arch/private/
$HOME/.sh/backup.sh
cp -a $HOME/.tmp/backup/* $HOME/git/arch/private
rm -r -f $HOME/.tmp/backup
cd $HOME/git/arch
git add -A
git commit -m "update latest setting files"
git push -v
notify-send -i $icon "config files saved to git"