#!/usr/bin/bash
set -euo pipefail

cp "$HOME/.cache/wal/hyprcolors.lua" "$HOME/.config/hypr/hyprcolors.lua"
fuzzel.sh
dunst.sh
"$HOME/.config/waybar/launch.sh"
