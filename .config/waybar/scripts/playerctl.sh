#!/bin/bash

playerctl metadata --format '{ \"text\": \"{{markup_escape(title)}} - {{markup_escape(artist)}}\", \"alt\": \"{{status}}\", \"tooltip\": \"{{playerName}}:  {{markup_escape(title)}} - {{markup_escape(artist)}}\" }'
