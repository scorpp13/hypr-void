#!/usr/bin/bash

GREEN='\033[0;32m'

curl "ru.wttr.in/Pskov?F"
echo -e "$GREEN"
read -rp "Press Enter to continue" </dev/tty
