#!/bin/bash   

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NONE='\033[0m'

echo -e "${CYAN}"
cat <<"EOF"
┳┳┓•        
┃┃┃┓┏┓┏┓┏┓┏┓
┛ ┗┗┛ ┛ ┗┛┛ 
EOF

if gum confirm "Change an existing xbps mirror?" ;then
	gum spin --title "xmirror starting..." -- sleep 0.5
	sudo xmirror
elif [ $? -eq 130 ]; then
	notify-send "Canceled by user"
	exit 130
else
	notify-send "xmirror interrupted"
	exit;
fi
notify-send "Changing mirror has finished"
