hl.on("hyprland.start", function ()

-- Start Pipewire
hl.exec_cmd("pipewire.sh")

-- Setup XDG
hl.exec_cmd("xdg.sh")

-- Load environment for hyprland
hl.exec_cmd("dbus-update-activation-environment --all")

-- Start Polkit Agent
hl.exec_cmd("/usr/libexec/hyprpolkitagent")

-- Start Notification Manager
hl.exec_cmd("dunst")

-- Start Autolock
hl.exec_cmd("hypridle")

-- Start Screenfilter
hl.exec_cmd("hyprsunset -t 5500")

-- Start Cliphist(ory)
hl.exec_cmd("wl-paste --watch cliphist store")

-- Initialize wallpaper
hl.exec_cmd("waypaper --restore")
	
-- Set cursor theme
hl.exec_cmd("cursor.sh")

-- Autostart apps
hl.exec_cmd("sleep 5 && udiskie -As")
hl.exec_cmd("sleep 10 && nm-applet")

end)
