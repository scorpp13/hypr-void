#!/usr/bin/env bash

# This script converts some video to a GIF. It prompts the user to select an
# video file with `gum filter` Set the frame rate, desired width, and max
# colors to use Then, converts the video to a GIF.

RED='\033[0;31m'                                                                                  
GREEN='\033[0;32m'                                                                                
YELLOW='\033[0;33m'                                                                               
BLUE='\033[0;34m'                                                                                 
PURPLE='\033[0;35m'                                                                               
CYAN='\033[0;36m'                                                                                 
NONE='\033[0m'

INPUT=$(gum filter --placeholder "Input file")
FRAMERATE=$(gum input --prompt "Frame rate: " --placeholder "Frame Rate" --prompt.foreground 240 --value "50")
WIDTH=$(gum input --prompt "Width: " --placeholder "Width" --prompt.foreground 240 --value "1200")
MAXCOLORS=$(gum input --prompt "Max Colors: " --placeholder "Max Colors" --prompt.foreground 240 --value "256")

BASENAME=$(basename "$INPUT")
BASENAME="${BASENAME%%.*}"

gum spin --title "Converting to GIF" -- ffmpeg -i "$INPUT" -vf "fps=$FRAMERATE,scale=$WIDTH:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=$MAXCOLORS[p];[s1][p]paletteuse" "$BASENAME.gif"
notify-send "Converting finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
