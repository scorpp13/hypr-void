#!/usr/bin/bash

set -e

ini3="$HOME/.config/gtk-3.0/settings.ini"
ini4="$HOME/.config/gtk-4.0/settings.ini"

read_ini_value () {
  local key="$1"
  local ini="$2"

  [ -f "$ini" ] || return 1
  grep -m1 -E "^[[:space:]]*${key}[[:space:]]*=" "$ini" 2>/dev/null \
    | sed -E 's/^[^=]*=[[:space:]]*//; s/[[:space:]]*$//'
}

theme="$(read_ini_value "gtk-cursor-theme-name" "$ini4" || true)"
size="$(read_ini_value "gtk-cursor-theme-size" "$ini4" || true)"

# Fallback to GTK3 if GTK4 doesn't exist / doesn't contain keys
if [ -z "$theme" ]; then
  theme="$(read_ini_value "gtk-cursor-theme-name" "$ini3" || true)"
fi
if [ -z "$size" ]; then
  size="$(read_ini_value "gtk-cursor-theme-size" "$ini3" || true)"
fi

theme="${theme:-Adwaita}"
size="${size:-24}"
size="$(echo "$size" | sed -E 's/[^0-9].*//')"
size="${size:-24}"

hyprctl setcursor "$theme" "$size" >/dev/null 2>&1 || true
