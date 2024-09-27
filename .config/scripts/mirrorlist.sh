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
    echo -e "${GREEN}"
    echo "xmirror started..."
    echo -e "${NONE}"
    sudo xmirror
        elif [ $? -eq 130 ]; then
            exit 130
        else
            exit;
fi
notify-send "Changing xbps mirror has finished"
