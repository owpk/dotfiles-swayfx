#!/bin/bash

url=$(wl-paste)
srch="? ${url}"
$1 "$srch"
