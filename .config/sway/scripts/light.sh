#!/bin/sh

SUNSET_CHANGE_STATE_VAR=/tmp/SUNSET_CHANGE_STATE_VAR
SUNSET_PID=$(pgrep wlsunset)

function sendNotify() {
    notify-send -t 1500 "Sunset $1"
}

function setStateOn() {
	STATE=1
    CHANGE_STATE=0
    echo $CHANGE_STATE > $SUNSET_CHANGE_STATE_VAR
}

function setStateOff() {
	STATE=0
	CHANGE_STATE=1
	echo $CHANGE_STATE > $SUNSET_CHANGE_STATE_VAR
}

function checkIfRunning() {
	if [ -z "$SUNSET_PID" ] ; then 
		setStateOff
	else 
		setStateOn
	fi
}

function on() {
    wlsunset -S 7:00 -s 22:00 &
    setStateOn
}

function off() {
    pkill wlsunset	
	setStateOff
}

checkIfRunning

arg=$1

if [ "$arg" == "1" ] ; then
  	on
    sendNotify "on"
elif [ "$arg" == "0" ] ; then 
  	off
    sendNotify "off"
fi
