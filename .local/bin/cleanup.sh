#!/usr/bin/bash
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
NONE='\033[0m'

echo -e "${YELLOW}"
cat <<"EOF"
┏┓┓ ┏┓┏┓┳┓
┃ ┃ ┣ ┣┫┃┃
┗┛┗┛┗┛┛┗┛┗
EOF

cleanup() { :; }
trap 'notify-send "CleanUp interrupted"; exit 0' INT TERM

orphans="$(xbps-remove -on | wc -l | tr -d ' ')"

if [ "$orphans" -ne 0 ]; then
	echo -e "${NONE}Found ${PURPLE}$orphans ${NONE}orphan packages"
  else
	notify-send "Nothing to clean"
	exit 0
fi

type=$(gum choose "Orphan Purge" "Full CleanUp")

if [ "$type" = "Orphan Purge" ]; then
	gum spin --title "Purging Orphan Packages..." -- sleep 0.5
	sudo xbps-remove -o
  elif [ "$type" = "Full CleanUp" ]; then
	gum spin --title "Starting Full System CleanUp..." -- sleep 0.5
	sudo xbps-remove -o
	sudo xbps-remove -OO
  else
	notify-send "Canceled by user"
	exit 130
fi

notify-send "CleanUp finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
