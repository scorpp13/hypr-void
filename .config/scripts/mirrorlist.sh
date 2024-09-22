#!/bin/sh   

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

if gum confirm "Update pacman mirrorlist now?" ;then
    echo -e "${GREEN}"
    echo "Fetching and ranking a live mirrorlist started..."
    echo -e "${NONE}"
	# rankmirrors is a part of pacman-contrib
    curl -s "https://archlinux.org/mirrorlist/?country=SE&country=DE&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 - | sudo tee /etc/pacman.d/mirrorlist
        elif [ $? -eq 130 ]; then
            exit 130
        else
            exit;
fi
    echo -e "${GREEN}"
    echo "Ending..."
    echo -e "${NONE}"
    sudo pacman -Syyuu
    sleep 1
notify-send "Creation a fresh mirrorlist finished"
