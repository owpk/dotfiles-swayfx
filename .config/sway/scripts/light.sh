#!/bin/sh

defaultSunset() {
  wlsunset -S 7:00 -s 22:00
}

network=$($DOTFILES_ROOT/scripts/check-network.sh)

if [ network -e "1" ]
then
  CONTENT=$(curl -s https://freegeoip.app/json/)
  longitude=$(echo $CONTENT | jq .longitude)
  latitude=$(echo $CONTENT | jq .latitude)
  if [ -z $longitude ] || [ -z $latitude ]
  then
    wlsunset -l $latitude -L $longitude
  else defaultSunset
  fi
else
  defaultSunset
fi
