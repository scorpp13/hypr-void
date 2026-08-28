-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- QT Theme
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- User Defined Apps
require("/conf/userapps")
