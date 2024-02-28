#!/usr/bin/sh

DEFAULT_BROWSER=$(xdg-settings get default-web-browser)

for p in ${XDG_DATA_DIRS//:/ }; do 
    APP_PATH="$p/applications"
    if [ -d $APP_PATH ]; then
        BROWSER=$(find $APP_PATH -name $DEFAULT_BROWSER)
    fi
done

RAW=$(grep -Rnw -m 1 $BROWSER -e 'Exec=')
BROWSER_CMD=$(echo $RAW | cut -d '=' -f 2)
BROWSER_CMD=$(echo $BROWSER_CMD | cut -d ' ' -f 1)

echo $BROWSER_CMD
