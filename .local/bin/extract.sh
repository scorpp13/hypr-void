#!/usr/bin/bash
set -euo pipefail

GREEN='\033[0;32m'

DIR="$(gum file --directory "$HOME")"
INPUT="$(find "$DIR" -type f | gum choose --limit 1)"

if ! gum confirm "Extract selected file?"; then
  notify-send "Canceled by user"
  exit 130
fi

cd "$DIR"

gum spin --title "Extracting..." -- bash -lc '
input="$1"
case "$input" in
  *.tar.bz2) tar xjf "$input"	 ;;
  *.tar.gz)  tar xzf "$input"	 ;;
  *.tbz2)    tar xjf "$input"	 ;;
  *.tgz)     tar xzf "$input"	 ;;
  *.tar)     tar xf "$input"	 ;;
  *.tar.xz)  tar xf "$input"	 ;;
  *.bz2)     bunzip2 "$input"	 ;;
  *.gz)      gunzip "$input"	 ;;
  *.Z)       uncompress "$input" ;;
  *.zip)     unzip "$input"		 ;;
  *.rar)     unrar x "$input"	 ;;
  *.7z)      7z x "$input"		 ;;
  *)
    notify-send "'"$INPUT"' isn'\''t a valid archive file"
    exit 1
    ;;
esac
' -- "$INPUT"

notify-send "Extracting finished"
echo -e "${GREEN}"
read -rp "Press Enter to continue" </dev/tty
