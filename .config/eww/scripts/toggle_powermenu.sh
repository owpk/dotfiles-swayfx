#!/bin/bash

if [[ -z $(eww list-windows | grep '*powermenu') ]]; then
    eww open powermenu
elif [[ -n $(eww list-windows | grep '*powermenu') ]];then
    eww close powermenu
fi
