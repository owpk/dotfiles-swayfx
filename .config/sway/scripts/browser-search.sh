#!/bin/bash

url=$(wl-paste)
srch="? ${url}"
$($HOME/.config/sway/scripts/get-default-browser.sh) "$srch"
