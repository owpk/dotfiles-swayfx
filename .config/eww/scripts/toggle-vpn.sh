#!/bin/bash

eww="eww -c $HOME/.config/eww"

if [[ $($eww list-windows | grep '*vpn') == "" ]]; then
  # closed, opening
  $eww open vpn
else
  # open, closing
  $eww close vpn
fi
