#!/bin/bash
# translate-shell dependency required !

txt=$(pbpaste | trans -b -t "$1")
echo "$txt" | pbcopy
osascript -e "display dialog \"$txt\" with title \"Translatation\""
