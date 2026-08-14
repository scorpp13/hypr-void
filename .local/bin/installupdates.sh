#!/usr/bin/bash
set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'

echo -e "${BLUE}"
cat <<"EOF"
┳┳  ┳┓┏┓┏┳┓┏┓
┃┃┏┓┃┃┣┫ ┃ ┣ 
┗┛┣┛┻┛┛┗ ┻ ┗┛
  ┛          
EOF

cleanup() { :; }
trap 'notify-send "Update interrupted"; exit 0' INT TERM

if gum confirm "Start update right now?"; then
  gum spin --title "Starting Update..." -- sleep 0.5
  sudo xbps-install -Su
else
  notify-send "Canceled by user"
  exit 130
fi


notify-send "Update complete"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
