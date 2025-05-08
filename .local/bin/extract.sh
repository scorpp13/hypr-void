#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NONE='\033[0m'

DIR=$(gum file --directory $HOME)
INPUT=$(ls $DIR | gum choose --limit 1)
if gum confirm "Extract selected file?"; then
	cd $DIR && gum spin --title "Extracting..." -- sleep 1
	if [ -f $INPUT ]; then
		case $INPUT in
			*.tar.bz2)	tar xjf $INPUT		;;
			*.tar.gz)	tar xzf $INPUT		;;
			*.bz2)		bunzip2 $INPUT		;;
			*.rar)		unrar x $INPUT		;;
			*.gz)		gunzip $INPUT		;;
			*.tar)		tar xf $INPUT		;;
			*.tar.xz)	tar xf $INPUT		;;
			*.tbz2)		tar xjf $INPUT		;;
			*.tgz)		tar xzf $INPUT		;;
			*.zip)		unzip $INPUT		;;
			*.Z)		uncompress $INPUT	;;
			*.7z)		7zz x $INPUT		;;
			*) notify-send "$INPUT isn't a valid archive file" && exit;;
		esac
	else
		notify-send "$INPUT can't be extracted"
		exit;
	fi
	elif [ $? -eq 130 ]; then
		notify-send "Canceled by user"
		exit 130
	else
		notify-send "Extracting interrupted"
		exit;
fi
notify-send "Extracting finished"	
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
