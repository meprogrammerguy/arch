#!/bin/bash
# gets location curl -s https://manjaro-sway.download/geoip | jq > $HOME/.tmp/current_location.txt
# gets city curl -s https://manjaro-sway.download/geoip | jq -r '.city' > $HOME/.tmp/location_city.txt
#time=$(LC_ALL=C TZ=LC_NUMERIC date +'%A, %d. %B')
#time=$(TZ='America/Chicago' date +'%H:%M:%S')
#"on-click": "xdg-open \"https://wttr.in/$(curl -s https://manjaro-sway.download/geoip | jq -r '.city')\"",

#helena=($curl -s https://wttr.in/35080) | jp
#echo $helena | jp
#  [46.592712,-112.036109] works
# from manjaro 33.26600,-86.90410
curl -s https://manjaro-sway.download/geoip | jq > $HOME/.tmp/current_location.txt
location_city=$(cat "$HOME/.tmp/current_location.txt" | jq -r '.city') > $HOME/.tmp/location_city.txt
if [ -f $HOME/.tmp/override_city.txt ]
then
    override_city=$(cat "$HOME/.tmp/override_city.txt" > /dev/null)
fi
if ! [ -f $HOME/.tmp/home_city.txt ]
then
    echo "Alabaster" > $HOME/.tmp/home_city.txt
    #home_city=$(cat "$HOME/.tmp/home_city.txt" > /dev/null)
fi
        #// accepts -c/--city <city> -t/--temperature <C/F> -d/--distance <km/miles>
if [ -z $override_city ]
then
    #echo "location city: $location_city"
    #/usr/share/sway/scripts/weather.py -t F -d miles -c "$location_city" | jq
    wttrbar -m --fahrenheit --location 46.592712,-112.036109 #$location_city
else
    #echo "location city: $override_city"
    #/usr/share/sway/scripts/weather.py -t F -d miles -c "$override_city" | jq
    wttrbar -m --fahrenheit --location $override_city
fi