#!/bin/bash
KEYBOARD=`swaymsg -r -t get_inputs | grep -i identifier | grep -i keyboard | tail -1| sed 's/"identifier": //; s/ //g; s/,//'`

if [[ $1 ]]
then
   KEYBOARD="\"$1\""
fi

swaymsg -r -t get_inputs | jq -r \
    "first(.[]|select(.identifier == $KEYBOARD and .type == \"keyboard\")) \
    | .xkb_active_layout_name"

swaymsg -mrt subscribe '["input"]' | jq -r --unbuffered \
    "select(.change == \"xkb_layout\")
    | .input
    | select(.identifier == $KEYBOARD and .type == \"keyboard\") \
    | .xkb_active_layout_name"

