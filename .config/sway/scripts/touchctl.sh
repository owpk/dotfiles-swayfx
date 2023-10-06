#!/bin/bash
if [ $1 == '-on' ]; then
   /usr/bin/synclient TouchpadOff=0
elif [ $1 == '-off' ]; then
   /usr/bin/synclient TouchpadOff=1
fi
