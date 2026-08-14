#!/usr/bin/bash
set -e

. "${HOME}/.cache/wal/colors.sh"

config="${HOME}/.config/dunst/dunstrc"
ini="${HOME}/.config/gtk-3.0/settings.ini"

read_ini_value() {
  local key="$1"
  local ini_file="$2"
  grep -m1 -E "^[[:space:]]*${key}[[:space:]]*=" "$ini_file" 2>/dev/null \
    | sed -E 's/^[^=]*=[[:space:]]*//; s/[[:space:]]*$//'
}

icon="$(read_ini_value "gtk-icon-theme-name" "$ini")"

font_raw="$(read_ini_value "gtk-font-name" "$ini")"
# Keep font family only (e.g. "Adwaita Sans" from 'Adwaita Sans 11')
font="$(printf '%s' "$font_raw" | sed -E 's/[[:space:]]+[0-9]+([.,][0-9]+)?$//')"
font="${font:-Sans}"

# position on screen
if grep -q "top" "${HOME}/.cache/.themestyle.sh" 2>/dev/null; then
  origin="top-right"
elif grep -q "bottom" "${HOME}/.cache/.themestyle.sh" 2>/dev/null; then
  origin="bottom-right"
else
  origin="top-right"
fi

frame_color="#${foreground#\#}"   # ensures exactly "#rrggbb"
foreground="#ffffff"
background="#${background#\#}70" # adds alpha

tmp="$(mktemp)"
head -n -6 "$config" > "$tmp"

printf 'origin = %s\nfont = %s 14\nicon_theme = %s\nframe_color = "%s"\nforeground = "%s"\nbackground = "%s"\n' \
  "$origin" "$font" "$icon" "$frame_color" "$foreground" "$background" >> "$tmp"

mv "$tmp" "$config"
dunstctl reload
