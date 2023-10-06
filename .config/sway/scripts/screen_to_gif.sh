#!/bin/bash
q=1366
g=0
args=($@)
for (( i=0; i<"$#"; i++ ))
do
   if [[ ${args[$i]} == "-q" ]] ; then
       i=$(( i + 1 ))
       q=${args[$i]}
    elif [[ ${args[$i]} == "-g" ]] ; then
       g=1
    fi
done

TMP="/tmp/stg_rec.mp4"
if [ -f $TMP ]
then
   rm $TMP
fi

FILENAME="gif-`date +%F-%T`"
DIR=`xdg-user-dir PICTURES`/gif
mkdir -p $DIR

if [[ $g -eq 0 ]] ; then
   wf-recorder -f $TMP
elif [[ $g -eq 1 ]] ; then
   wf-recorder -g "$(slurp)" -f $TMP
fi

ffmpeg \
  -i $TMP \
  -r 15 \
  -vf scale=$q:-1 \
  "$DIR/$FILENAME.gif" && rm $TMP && \
notify-send -t 5000 "GIF SAVED" "$DIR/$FILENAME.gif"
