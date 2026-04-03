#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[1;36m'
NONE='\033[0m'

echo -e "${YELLOW}"
cat <<"EOF"
┏┓┓ ┏┓┏┓┳┓
┃ ┃ ┣ ┣┫┃┃
┗┛┗┛┗┛┛┗┛┗
EOF

orphans=$(xbps-remove -on | wc -l)
#oldkernel=$(vkpurge list | wc -l)
if [ "$orphans" -ne 0 ]; then #|| [ "$oldkernel" -ne 0 ]; then
	echo -e "${NONE}Found ${PURPLE}$orphans ${NONE}orphan packages" #and ${PURPLE}$oldkernel ${NONE}old_kernels"
		else
			notify-send "Nothing to clean"
		exit;
fi

type=$(gum choose "Orphan Purge" "Full CleanUp")
if [ "$type" == "Orphan Purge" ]; then
	gum spin --title "Purging Orphan Packages..." -- sleep 0.5 #and Old Kernels..." -- sleep 0.5
	#sudo vkpurge rm all &&
	sudo xbps-remove -o
		elif [ "$type" == "Full CleanUp" ]; then
			gum spin --title "Starting Full System CleanUp..." -- sleep 0.5
			#sudo vkpurge rm all &&
			sudo xbps-remove -o && sudo xbps-remove -OO
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
