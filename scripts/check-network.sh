#!/bin/bash

# Test for network conection
for interface in $(ls /sys/class/net/ | grep -v lo);
do
  if [[ $(cat /sys/class/net/$interface/carrier) = 1 ]]; then OnLine=1; fi
done
if ! [ $OnLine ] 
	then echo "0"
	else echo "1"
fi
