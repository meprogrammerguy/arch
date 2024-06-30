#!/bin/bash
#
# tool that auto swaps between (manjaro weather.py app) and (wttrbar app from arch AUD)
#   when weather.py fails (web site down) it just prints nothing
#   with this script wttrbar is the fallback app
#       result is much more weather uptime on my laptop
#
title="weather"
icon="/usr/share/icons/Dracula/24@2x/places/user-home.svg"
config_file="$HOME/.config/weather.cfg"
final_result="$HOME/.tmp/weather_1.txt"
final_method="primary"
city=$(cat "$config_file" | grep "city" | sed 's|.*=||')
method_1=$"curl -s https://manjaro-sway.download/weather/Alabaster?temperature_unit=fahrenheit&wind_speed_unit=mph"
method_1=$"curl -s https://manjaro-sway.download/weather/$city?temperature_unit=fahrenheit&wind_speed_unit=mph"
method_2=$"/usr/bin/wttrbar -m  --fahrenheit --location $city"
$method_1 > "$HOME/.tmp/weather_1.txt"
test=$(cat "$final_result" | grep "tooltip")
if [[ -z $test ]]
then
    final_result="$HOME/.tmp/weather_2.txt"
    final_method="secondary"
    $method_2 > "$HOME/.tmp/weather_2.txt"
fi
test=$(cat "$final_result" | grep "tooltip")
if [[ -z $test ]]
then
    final_result="$HOME/.tmp/weather_bad.txt"
    final_method="*** error ***"
    bad_weather=$(echo '"text": "\u2600\ufe0f ?? \u00b0F", "tooltip": "manjaro and wttrbar\n\nSUCK"') 
    echo "{$bad_weather}" > "$HOME/.tmp/weather_bad.txt"
fi
if [[ $final_method -eq "error" ]]
then
    notify-send -i $icon "$title - $final_method" "SUCCESS"
else
    notify-send -i $icon "$title - $final_method" "BORKED"
fi
cat "$final_result" # | jq