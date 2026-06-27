local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)
hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
-- nm_applet window rule
hl.window_rule({
	name = "nm-connection-editor",
	match = { class = "nm-connection-editor" },
	float = true,
	persistent_size = true,
})
-- waypaper window rule
hl.window_rule({
	name = "waypaper",
	match = { class = "waypaper" },
	float = true,
	persistent_size = true,
})
-- nwg-look window rule
hl.window_rule({
	name = "nwg-look",
	match = { class = "nwg-look" },
	float = true,
	persistent_size = true,
})
-- qt6ct window rule
hl.window_rule({
	name = "qt6ct",
	match = { class = "qt6ct" },
	float = true,
	persistent_size = true,
})
-- Galculator window rule
hl.window_rule({
	name = "galculator",
	match = { class = "galculator" },
	float = true,
	persistent_size = true,
})
-- ColorPicker window rule
hl.window_rule({
	name = "colorpicker.sh",
	match = { class = "colorpicker.sh" },
	float = true,
	size = { 300, 150 },
})
-- Weather window rule
hl.window_rule({
	name = "wttr.sh",
	match = { class = "wttr.sh" },
	float = true,
	size = { 1300, 950 },
})
-- Default size of floating windows
hl.window_rule({
	name = "floating",
	match = { initial_class = "floating" },
	float = true,
	size = { 850, 600 },
})
-- Browser tile
hl.window_rule({
	name = "vivaldi-stable",
	match = { class = "vivaldi-stable" },
	tile = true,
})
-- Browser iddle inhibit in fullscreen mode
hl.window_rule({
	name = "vivaldi-stable",
	match = { class = "vivaldi-stable" },
	idle_inhibit = fullscreen,
})
-- mpv iddle inhibit in fullscreen mode
hl.window_rule({
	name = "mpv",
	match = { class = "mpv" },
	idle_inhibit = fullscreen,
})
-- gtk-layer-shell layer rule
hl.layer_rule({
	name = "gtk-layer-shell",
	match = { namespace = "gtk-layer-shell" },
	blur = true,
})
-- logout dialog layer rule
hl.layer_rule({
	name = "logout_dialog",
	match = { namespace = "logout_dialog" },
	blur = true,
})
-- Waybar layer rule
hl.layer_rule({
	name = "waybar",
	match = { namespace = "waybar" },
	blur = true,
	xray = 1,
	ignore_alpha = 0.01,
})
-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
