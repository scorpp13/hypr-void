#!/usr/bin/bash

if [[ -z $(hyprctl workspaces | grep special:magic) ]]; then
    hyprctl dispatch movetoworkspacesilent special:magic
else
    hyprctl --batch 'dispatch togglespecialworkspace magic;dispatch movetoworkspace +0'
fi
