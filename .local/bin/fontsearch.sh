#!/usr/bin/bash

NONE='\033[0m'

fc-list | grep -ioE ": [^:]*$1[^:]+:" | sed -E 's/(^: |:)//g' | tr , \\n | sort | uniq | \
gum style --border="rounded" --border-foreground="8" \
--foreground="10" --margin="0 2" --padding="0 2"
echo -e "${NONE}"
read -rp "Press Enter to continue" </dev/tty
