#!/bin/bash
audio-recorder -c start

# TODO check if this occures any perf problem
audio-recorder --show-icon=1

r_status() {
    R_STATUS="$(audio-recorder -c status)"
}

r_status

while [ "$R_STATUS" != "on" ]; do r_status; done

while [ "$R_STATUS" != "off" ]
do 
    r_status
    if [ "$R_STATUS" = "not running" ]; then exit 1; fi
done

audio-recorder -c hide
