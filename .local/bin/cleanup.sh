#!/usr/bin/env bash

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
	gum spin --title "Cleaning..." -- sleep 0.5
	sudo xbps-remove -Oo
elif [ $? -eq 130 ]; then
	notify-send "Canceled by user"
	exit 130
else
	notify-send "CleanUp interrupted"
	exit;
fi
notify-send "CleanUp finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
