#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NONE='\033[0m'

echo -e "${YELLOW}"
cat <<"EOF"
┏┓┓ ┏┓┏┓┳┓
┃ ┃ ┣ ┣┫┃┃
┗┛┗┛┗┛┛┗┛┗
EOF

if gum confirm "Start CleanUp right now?"; then
	if gum confirm "Run FullClean including cache and old configs?"; then
		gum spin --title "Starting FullClean..." -- sleep 0.5
		sudo xbps-remove -o && sudo xbps-remove -OO
	else	
		gum spin --title "Starting OrphanClean..." -- sleep 0.5
		sudo xbps-remove -o
	fi
		else
			notify-send "CleanUp interrupted"
		exit;
fi
notify-send "CleanUp finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
