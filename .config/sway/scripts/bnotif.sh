dir="/sys/class/backlight/amdgpu_bl1/brightness"
char=$1
script=$HOME/.config/sway/scripts/bcklr.sh

function get_bright {
   cat $dir
}

function send_notification {
  br=$(get_bright)
  val=$(( $br / 2 ))
  notify-send -u low "bright: ${val}%"
}

if  [[ $char == "-d" ]]
   then
    sudo $script -d
elif [[ $char == "-r" ]]
   then
    sudo $script -r
fi

send_notification
