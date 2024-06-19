#!/usr/bin/env bash

time=$(LC_ALL=C TZ=LC_NUMERIC date +'%A, %d. %B')
city="Alabaster"
wttr=$(curl https://wttr.in/{$city}?format=3)
echo '<span size="35000" foreground="#998000">'$time'</span><span size="30000" foreground="#ccc">'
echo $wttr'</span>'