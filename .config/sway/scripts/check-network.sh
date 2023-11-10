#!/bin/bash

wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo "1" # Online
else
    echo "0" # Offline
fi
