#!/bin/bash

gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.List \
   | sed "s/^('//;s/',)$//;s/''//g" \
   | jq -c '[.[] | select (.frame_type == 0 and .window_type == 0) | {id: .id,wm_class: .wm_class}]' \
   | jq .
