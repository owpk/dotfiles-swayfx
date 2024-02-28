#!/bin/bash

while [ -z "$(ip addr show wlp0s20f3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)" ]; 
do 
    echo "0"
    sleep 1 
done

echo "1"
