tooltip_msg="vnc server status"
OFF_MSG="off"
ON_MSG="on"
VNC_CHANGE_STATE_VAR=/tmp/VNC_CHANGE_STATE_VAR
VNC_PID=$(pgrep wayvnc)

function echoOn() {
		printf "{ \"text\": \"%s\", \"tooltip\": \"%s\" }\n" \
       "$ON_MSG" "$tooltip_msg" 
}

function echoOff() {
		printf "{ \"text\": \"%s\", \"tooltip\": \"%s\" }\n" \
       "$OFF_MSG" "$tooltip_msg" 
}

function setStateOn() {
		STATE=1
		CHANGE_STATE=0
		echo $CHANGE_STATE > $VNC_CHANGE_STATE_VAR
}

function setStateOff() {
		STATE=0
		CHANGE_STATE=1
		echo $CHANGE_STATE > $VNC_CHANGE_STATE_VAR
}

function checkIfRunning() {
	if [ -z "$VNC_PID" ] ; then 
		setStateOff
	else 
		setStateOn
	fi
}

function on() {
    wayvnc 0.0.0.0 &
		setStateOn
		pkill '-RTMIN+5' waybar
}

function off() {
		kill $VNC_PID
		setStateOff
		pkill '-RTMIN+5' waybar
}

checkIfRunning

arg=$1

if [ "$arg" == "1" ] ; then
  	on
elif [ "$arg" == "0" ] ; then 
  	off
fi

if [ $STATE -eq 0 ] ; then
		echoOff
elif [ $STATE -eq 1 ] ; then
		echoOn
fi
