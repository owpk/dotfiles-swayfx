#!/bin/bash
url=$(wl-paste)
srch="? ${url}"
google-chrome-stable "$srch"
