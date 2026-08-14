#!/usr/bin/bash

GREEN='\033[0;32m'

DIR="$(gum file --directory "$HOME")"

mapfile -t INPUT < <(find "$DIR" -type f -name '*.png' | gum choose --no-limit) || exit 1

if [[ ${#INPUT[@]} -eq 0 ]]; then
	notify-send "Nothing selected"
	exit 0
fi

gum confirm "Convert selected images?" || {
	notify-send "Canceled by user"
	exit 130
}

cd "$DIR" || exit 1

gum spin --title "Converting..." -- mogrify -format jpg "${INPUT[@]}"

notify-send "Converting finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
