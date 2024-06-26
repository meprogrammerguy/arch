#!/usr/bin/env bash

#time=$(LC_ALL=C TZ=LC_NUMERIC date +'%A, %d. %B')
time=$(TZ='America/Chicago' date +"%H:%M")
#city="Alabaster"
#wttr=$(curl https://wttr.in/{$city}?format=2)
wttr=$(curl https://wttr.in/?format=3)
#echo '<span size="35000" foreground="#998000">'$time'</span><span size="30000" foreground="#ccc">'
echo $wttr #'</span>'