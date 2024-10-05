#!/bin/bash

# This script merges some images to one file. It prompts the user to select an
# image file(s); set the number of columns and lines for an output file.
DIR=$(gum file --directory $HOME)
INPUT=$(ls $DIR | gum choose --no-limit)
BASENAME=$(basename "$INPUT")
EXTENSION="${BASENAME##*.}"
OUTPUT=merge_"$(date '+%d%m%y_%H%M%S')"
FORMAT=$(gum input --prompt "Merging format: " --placeholder "columns X lines")
if gum confirm "Merge selected images?"; then
	cd $DIR && gum spin --title "Merging..." -- \
	montage $INPUT -tile $FORMAT -geometry +0+0 $OUTPUT.$EXTENSION
	elif [ $? -eq 130 ]; then
		notify-send "Canceled by user"
		exit 130
	else
		notify-send "Merging interrupted"
		exit;
fi
notify-send "Merging finished"
