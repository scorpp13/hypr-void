#!/usr/bin/bash   

GREEN='\033[0;32m'
CYAN='\033[0;36m'

echo -e "${CYAN}"
cat <<"EOF"
┳┳┓•        
┃┃┃┓┏┓┏┓┏┓┏┓
┛ ┗┗┛ ┛ ┗┛┛ 
EOF

if gum confirm "Change an existing xbps mirror?" ;then
	gum spin --title "Starting xmirror..." -- sleep 0.5
	sudo xmirror
		elif [ $? -eq 130 ]; then
			notify-send "Canceled by user"
		exit 130
		else
			notify-send "xmirror interrupted"
		exit;
fi

notify-send "Changing mirror has finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
