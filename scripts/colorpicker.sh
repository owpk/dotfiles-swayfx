#!/bin/bash
grim -g "$(slurp -p)" - -t png -o | convert png:- -format '%[pixel:s]\n' info:- | awk -F '[(,)]' '{printf("#%02x%02x%02x\n",$2,$3,$4)}'
