#/bin/sh

SEARCH_FOLDER="$1"

for f in $SEARCH_FOLDER
do
    if [ -d "$f" ]
    then
        for ff in $f/*
        do      
            echo "Processing $ff"
        done
    else
        echo "Processing file $f"
    fi
done
