#!/bin/bash
wifi_icon="/usr/share/icons/Dracula/22/devices/network-wireless.svg"
nmcli device wifi > $HOME/.wifi-found.txt
//notify-send -i $wifi_icon 'wifi locations discovered' too early to send this one