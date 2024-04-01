#!/bin/bash

url=$(pbpaste)
srch="https://google.com/search?q=${url}"
$(open "$srch")
