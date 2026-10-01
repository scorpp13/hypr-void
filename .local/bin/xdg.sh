#!/bin/sh
dbus-update-activation-environment --all
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 1
/usr/libexec/xdg-desktop-portal &
