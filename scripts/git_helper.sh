#!/bin/bash
BRANCH=`git branch --show current`
git add .
printf "commit message: "
read msg
git commit -m "$msg"
git push origin $BRANCH
