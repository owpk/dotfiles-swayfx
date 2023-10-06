#!/bin/bash
CONFIG=~/.config/sway/config.d/default
function print() {
   cat $CONFIG | grep -v ^\# | grep mod+ \
      | sed 's/.*\$mod/super/g; s/\t/ /g; s/ \+/ /g' \
      | sort | grep --color=auto '^[^ ]*'
}
print
read -r -n 1 keyinput
