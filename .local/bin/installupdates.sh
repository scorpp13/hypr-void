#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NONE='\033[0m'

echo -e "${BLUE}"
cat <<"EOF"
┳┳  ┳┓┏┓┏┳┓┏┓
┃┃┏┓┃┃┣┫ ┃ ┣ 
┗┛┣┛┻┛┛┗ ┻ ┗┛
  ┛          
EOF

if gum confirm "Start update right now?"; then
	gum spin --title "Starting Update..." -- sleep 0.5
	sudo xbps-install -Su
elif [ $? -eq 130 ]; then
	notify-send "Canceled by user"
	exit 130
else
	notify-send "Update interrupted"
	exit;
fi
notify-send "Update complete"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
