#!/usr/bin/bash
set -euo pipefail

GREEN=$'\033[0;32m'
CYAN=$'\033[0;36m'

echo -e "${CYAN}"
cat <<"EOF"
┳┳┓•
┃┃┃┓┏┓┏┓┏┓┏┓
┛ ┗┗┛ ┛ ┗┛┛ 
EOF

cleanup() { :; }
trap 'notify-send "xmirror interrupted"; exit 0' INT TERM

if gum confirm "Change an existing xbps mirror?"; then
  gum spin --title "Starting xmirror..." -- sleep 0.5
  sudo xmirror
else
  notify-send "Canceled by user"
  exit 130
fi

notify-send "Changing mirror has finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
