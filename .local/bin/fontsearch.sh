#!/usr/bin/env bash

RED='\033[0;31m'                                                                                  
GREEN='\033[0;32m'                                                                                
YELLOW='\033[0;33m'                                                                               
BLUE='\033[0;34m'                                                                                 
PURPLE='\033[0;35m'                                                                               
CYAN='\033[0;36m'                                                                                 
NONE='\033[0m'

fc-list | grep -ioE ": [^:]*$1[^:]+:" | sed -E 's/(^: |:)//g' | tr , \\n | sort | uniq | \
gum style --border="rounded" --border-foreground="8" \
--foreground="10" --margin="0 2" --padding="0 2"
echo -e "${NONE}"
read -rp "Press Enter to continue" exit
