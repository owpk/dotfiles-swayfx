#!/bin/bash 
echo '/usr/share/icons/Papirus-Dark/96x96/apps/kcmmemory.svg'
echo $(free -mth | tail -1 | awk '{print $3}')
