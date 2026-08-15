#!/usr/bin/bash
exec 200>/tmp/waybar.lock
flock -n 200 || exit 0

pkill waybar || true
sleep 0.5

themestyle="/colour-top"
if [ -f ~/.cache/.themestyle.sh ]; then
  themestyle="$(cat ~/.cache/.themestyle.sh)"
else
  mkdir -p ~/.cache
  echo "$themestyle" > ~/.cache/.themestyle.sh
fi

# take first theme if multiple separated by ';'
IFS=';' read -ra arrThemes <<< "$themestyle"
theme="${arrThemes[0]}"

# normalize leading slash
theme="${theme#/}"

if [ ! -f "$HOME/.config/waybar/themes/$theme/style.css" ]; then
  theme="colour-top"
fi

cfg_file="config"
css_file="style.css"

waybar -c "$HOME/.config/waybar/themes/$theme/$cfg_file" \
       -s "$HOME/.config/waybar/themes/$theme/$css_file" &

flock -u 200
exec 200>&-
