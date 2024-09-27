#!/bin/bash

gum style \
	--foreground 13 --border-foreground 13 --border rounded --bold \
	--align center --width 30 --margin "0 2" --padding "1 0" \
	'R O F I   T H E M E S'
# config theme
gum style --foreground 10 --margin "1 2" 'CONFIG theme'
INPUT=$(ls $HOME/.config/rofi/themes | gum choose --limit 1)
CONFIG=$(basename "$INPUT")
CONFIGTHEME=$(echo "${CONFIG%%.*}" | awk -v q='"' '{print q $1 q}')
gum confirm "Set config_theme?" && \
gum spin --title "Writing..." -- sleep 1 && \
echo @theme $CONFIGTHEME > ~/.config/rofi/config_theme.rasi
# mpv theme
gum style --foreground 10 --margin "1 2" 'MPV theme'
INPUT=$(ls $HOME/.config/rofi/themes | gum choose --limit 1)
MPV=$(basename "$INPUT")
MPVTHEME=$(echo "${MPV%%.*}" | awk -v q='"' '{print q $1 q}')
gum confirm "Set mpv_theme?" && \
gum spin --title "Writing..." -- sleep 1 && \
echo @theme $MPVTHEME > ~/.config/rofi/mpv_theme.rasi
# screenshot theme
gum style --foreground 10 --margin "1 2" 'SCREENSHOT theme'
INPUT=$(ls $HOME/.config/rofi/themes | gum choose --limit 1)
SCREENSHOT=$(basename "$INPUT")
SCREENSHOTTHEME=$(echo "${SCREENSHOT%%.*}" | awk -v q='"' '{print q $1 q}')
gum confirm "Set screenshot_theme?" && \
gum spin --title "Writing..." -- sleep 1 && \
echo @theme $SCREENSHOTTHEME > ~/.config/rofi/screenshot_theme.rasi
# script theme
gum style --foreground 10 --margin "1 2" 'SCRIPT theme'
INPUT=$(ls $HOME/.config/rofi/themes | gum choose --limit 1)
SCRIPT=$(basename "$INPUT")
SCRIPTTHEME=$(echo "${SCRIPT%%.*}" | awk -v q='"' '{print q $1 q}')
gum confirm "Set script_theme?" && \
gum spin --title "Writing..." -- sleep 1 && \
echo @theme $SCRIPTTHEME > ~/.config/rofi/script_theme.rasi
# powermenu theme
gum style --foreground 10 --margin "1 2" 'POWERMENU theme'
INPUT=$(ls $HOME/.config/rofi/themes | gum choose --limit 1)
POWERMENU=$(basename "$INPUT")
POWERMENUTHEME=$(echo "${POWERMENU%%.*}" | awk -v q='"' '{print q $1 q}')
gum confirm "Set powermenu_theme?" && \
gum spin --title "Writing..." -- sleep 1 && \
echo @theme $POWERMENUTHEME > ~/.config/rofi/powermenu_theme.rasi
# print chosen rofi themes
clear
gum style --foreground 2 --faint 'config theme'
gum style --foreground 10 --bold $(awk '{print $2}' ~/.config/rofi/config_theme.rasi)
echo ''
gum style --foreground 2 --faint 'mpv theme'
gum style --foreground 10 --bold $(awk '{print $2}' ~/.config/rofi/mpv_theme.rasi)
echo ''
gum style --foreground 2 --faint 'screenshot theme'
gum style --foreground 10 --bold $(awk '{print $2}' ~/.config/rofi/screenshot_theme.rasi)
echo ''
gum style --foreground 2 --faint 'script theme'
gum style --foreground 10 --bold $(awk '{print $2}' ~/.config/rofi/script_theme.rasi)
echo ''
gum style --foreground 2 --faint 'powermenu theme'
gum style --foreground 10 --bold $(awk '{print $2}' ~/.config/rofi/powermenu_theme.rasi)
echo ''
