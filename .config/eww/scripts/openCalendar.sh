#!/bin/bash
# Opens eww calendar

LOCK_FILE="$HOME/.cache/eww-calendar.lock"
EWW_BIN="/usr/bin/eww"

run() {
    ${EWW_BIN} open calendar
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
    ${EWW_BIN} daemon
    sleep 1
fi

# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    touch "$LOCK_FILE"
    run
else
    ${EWW_BIN} close calendar
    rm "$LOCK_FILE"
fi
