#!/usr/bin/bash

GREEN='\033[0;32m'

# This script convert *.png images to *.jpg
DIR=$(gum file --directory "$HOME")
INPUT=$(find "$DIR" | gum choose --no-limit)
if gum confirm "Convert selected images?"; then
	cd "$DIR" && gum spin --title "Converting..." -- mogrify -format jpg $INPUT
	elif [ $? -eq 130 ]; then
		notify-send "Canceled by user"
		exit 130
	else
		notify-send "Converting interrupted"
	exit;
fi

notify-send "Converting finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
