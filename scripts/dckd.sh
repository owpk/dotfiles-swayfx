#!/bin/bash
if [[ $1 == '--clean' ]]
then
   docker stop $(docker ps -a -q)
   docker image rm -f $(docker image ls -q)
   docker volume rm -f $(docker volume ls -q)
fi
