local mainMod = "SUPER"

-- Local functions
local function layout_bind(bind_table)
    return function ()
        local workspace = hl.get_active_special_workspace() or
                          hl.get_active_workspace()
		if not workspace then
			return
		end
        local layout = workspace.tiled_layout
		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
    end
end
--
local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

-- Apps
hl.bind(mainMod .. " + CTRL + M", hl.dsp.exec_cmd("fuzzel"),
								  { description = "Menu" })
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"),
								  { description = "Waybar reload" })
hl.bind(mainMod .. " + CTRL + F", hl.dsp.exec_cmd("thunar"),
								  { description = "FileManager" })
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd("cliphist.sh"),
								  { description = "Clipboard" })
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("themeswitcher.sh"),
								  { description = "Waybar theme" })
hl.bind(mainMod .. " + RETURN",	  hl.dsp.exec_cmd("kitty -e fish"),
								  { description = "Terminal" })
hl.bind(mainMod .. " + PRINT",	  hl.dsp.exec_cmd("screenshot.sh"),
								  { description = "ScreenShoter" })
hl.bind(mainMod .. " + B",		  hl.dsp.exec_cmd("vivaldi"),
								  { description = "Browser" })
hl.bind(mainMod .. " + A",		  hl.dsp.exec_cmd("sol"),
								  { description = "Aisleriot" })
hl.bind(mainMod .. " + C",		  hl.dsp.exec_cmd("galculator"),
								  { description = "Calculator" })
hl.bind(mainMod .. " + H",		  hl.dsp.exec_cmd("kitty --class floating -e top"),
								  { description = "TopApp" })
hl.bind(mainMod .. " + Q",		  hl.dsp.exec_cmd("wlogout"),
								  { description = "WLogout" })
hl.bind(mainMod .. " + R",		  hl.dsp.exec_cmd("hyprctl reload"),
								  { description = "Hyprland reload" })
hl.bind(mainMod .. " + W",		  hl.dsp.exec_cmd("waypaper"),
								  { description = "Waypaper" })

-- Windows
hl.bind(mainMod .. " + F",			   hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
									   { description = "Toggle fullscreen" })
hl.bind(mainMod .. " + M",			   hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
									   { description = "Toggle maximize" })
hl.bind(mainMod .. " + T",			   hl.dsp.window.float({ action = "toggle" }),
									   { description = "Toggle float" })
hl.bind(mainMod .. " + J",			   hl.dsp.layout("togglesplit"),
									   { description = "Toggle split" })
hl.bind(mainMod .. " + K",			   hl.dsp.layout("swapsplit"),
									   { description = "Swap split" })
hl.bind(mainMod .. " + G",			   hl.dsp.group.toggle(),
									   { description = "Toggle group" })
hl.bind(mainMod .. " + S",			   hl.dsp.workspace.toggle_special("magic"),
									   { description = "Toggle magic workspace" })
hl.bind(mainMod .. " + Z", 			   zoom,
									   { description = "Magnifier" })
hl.bind(mainMod .. " + ESCAPE",		   hl.dsp.window.close(),
									   { description = "Kill active window" })
hl.bind(mainMod .. " + SHIFT + Q", 	   hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"),
									   { description = "Quit active window and all instances" })
hl.bind(mainMod .. " + SHIFT + S",	   hl.dsp.window.move({ workspace = "special:magic" }),
									   { description = "Move window to magic workspace" })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ workspace = "r-1" }),
									   { description = "Move window to previous workspace" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "r+1" }),
									   { description = "Move window to next workspace" })
hl.bind(mainMod .. " + up",			   hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true },
									   { description = "Reduce window height" })
hl.bind(mainMod .. " + down",		   hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true },
									   { description = "Increase window height" })
hl.bind(mainMod .. " + left",		   hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true },
									   { description = "Reduce window width" })
hl.bind(mainMod .. " + right",		   hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true },
									   { description = "Increase window width" })

-- Focus selected workspace / Move active window to selected workspace
for i = 1, 4 do
    local key = i
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),
											 { description = "Move window to workspace " .. i })
    hl.bind(mainMod .. " + " .. key, 		 hl.dsp.focus({ workspace = i}),
											 { description = "Focus workspace " .. i })
end

-- Toggle layouts
hl.bind(mainMod .. " + tab", function ()
    local layouts     = { "scrolling", "dwindle", "master", "monocle" }
    local workspace   = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end
    local next_layout = "dwindle"
    if not workspace then
        return
    end
    for i = 1, #layouts do
        if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
        end
    end
	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
end, { description = "Toggle layouts" })

-- Toggle float with mainMod + LMB and clicking
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.float({ action = "toggle" }),
								   { mouse = true, click = true, description = "Toggle-click float" })

-- Toggle magic with mainMod + RMB and clicking
hl.bind(mainMod .. " + mouse:273", function ()
    if hl.get_workspace("special:magic") then
        hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:magic" }))
        hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:magic" }))
    else
        hl.dispatch(hl.dsp.window.tag({ tag = "magic", window = hl.get_active_window() }))
        hl.dispatch(hl.dsp.window.move({ workspace = "special:magic", follow = false }))
    end
end, { mouse = true, click = true, description = "Toggle-click move to magic workspace" })

-- Toggle minimized with mainMod + MMB and clicking
hl.bind(mainMod .. " + mouse:274", function ()
    if hl.get_workspace("special:minimized") then
        hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
        hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
    else
        hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
        hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
    end
end, { mouse = true, click = true, description = "Toggle-click minimized state" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272",	hl.dsp.window.drag(),
									{ mouse = true, description = "Move window" })
hl.bind(mainMod .. " + mouse:273",	hl.dsp.window.resize(),
									{ mouse = true, description = "Resize window" })

-- Scroll with mainMod + mouse wheel through windows / workspaces
hl.bind(mainMod .. " + mouse_up", layout_bind({
    scrolling = hl.dsp.layout("swapcol l"), -- Scrolling: swap column with left one
    dwindle   = hl.dsp.layout("swapsplit"), -- Dwindle: swap window split
    monocle   = hl.dsp.layout("cycleprev"), -- Monocle: cycle prev window
    master    = hl.dsp.layout("cycleprev"), -- Master: cycle prev window
}), { mouse = true, description = "Scroll to previous window" })
--
hl.bind(mainMod .. " + mouse_down", layout_bind({
    scrolling = hl.dsp.layout("swapcol r"), -- Scrolling: swap column with right one
    dwindle   = hl.dsp.layout("togglesplit"), -- Dwindle: toggle window split
    monocle   = hl.dsp.layout("cyclenext"), -- Monocle: cycle prev window
    master    = hl.dsp.layout("cyclenext"), -- Master: cycle prev window
}), { mouse = true, description = "Scroll to next window" })
--
hl.bind(mainMod .. " + SHIFT + mouse_up",	hl.dsp.focus({ workspace = "r+1" }),
											{ mouse = true, description = "Scroll to previous workspace" })
hl.bind(mainMod .. " + SHIFT + mouse_down",	hl.dsp.focus({ workspace = "r-1" }),
											{ mouse = true, description = "Scroll to next workspace" })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",		hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",			hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",			hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",		hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", 	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
