#!/bin/bash

KH=$(java -cp $HOME/.config/waybar/scripts/ KeyHints $HOME/.config/sway/config.d/default)
echo $KH
