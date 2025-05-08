#!/usr/bin/env bash

RED='\033[0;31m'                                                                                  
GREEN='\033[0;32m'                                                                                
YELLOW='\033[0;33m'                                                                               
BLUE='\033[0;34m'                                                                                 
PURPLE='\033[0;35m'                                                                               
CYAN='\033[0;36m'                                                                                 
NONE='\033[0m'

# This script convert *.png images to *.jpg
DIR=$(gum file --directory $HOME)
INPUT=$(ls $DIR | gum choose --no-limit)
if gum confirm "Convert selected images?"; then
	cd "$DIR" && gum spin --title "Converting..." -- mogrify -format jpg "$INPUT"
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
