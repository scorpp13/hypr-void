local mainMod = "SUPER"
-- Apps
--hl.bind(mainMod .. " + S",				hl.dsp.exec_cmd("min_window.sh"), { description = "Hide to special workspace" })
hl.bind(mainMod .. " + RETURN",			hl.dsp.exec_cmd("kitty -e fish"), { description = "Terminal" })
hl.bind(mainMod .. " + B",				hl.dsp.exec_cmd("vivaldi"), { description = "Browser" })
hl.bind(mainMod .. " + A",				hl.dsp.exec_cmd("sol"), { description = "Aisleriot" })
hl.bind(mainMod .. " + C",				hl.dsp.exec_cmd("galculator"), { description = "Calculator" })
hl.bind(mainMod .. " + H",				hl.dsp.exec_cmd("kitty --class floating -e top"), { description = "Top App" })
hl.bind(mainMod .. " + PRINT",			hl.dsp.exec_cmd("screenshot.sh"), { description = "ScreenShoter" })
hl.bind(mainMod .. " + Q",				hl.dsp.exec_cmd("wlogout"), { description = "Logout Window" })
hl.bind(mainMod .. " + R",				hl.dsp.exec_cmd("hyprctl reload"), { description = "Hyprland Reload" })
hl.bind(mainMod .. " + W",				hl.dsp.exec_cmd("waypaper"), { description = "Waypaper" })
hl.bind(mainMod .. " + CTRL + M",		hl.dsp.exec_cmd("fuzzel"), { description = "Menu" })
hl.bind(mainMod .. " + CTRL + K",		hl.dsp.exec_cmd("keybindings.sh"), { description = "Keybindings" })
hl.bind(mainMod .. " + CTRL + R",		hl.dsp.exec_cmd("~/.config/waybar/launch.sh"), { description = "Waybar Reload" })
hl.bind(mainMod .. " + CTRL + F",		hl.dsp.exec_cmd("thunar"), { description = "Filemanager" })
hl.bind(mainMod .. " + CTRL + C",		hl.dsp.exec_cmd("cliphist.sh"), { description = "Clipboard" })
hl.bind(mainMod .. " + CTRL + T",		hl.dsp.exec_cmd("themeswitcher.sh"), { description = "Waybar Theme" })
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i}), { description = "Focus workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
end
-- Windows
hl.bind(mainMod .. " + ESCAPE",			hl.dsp.window.close(), { description = "Kill active window" })
hl.bind(mainMod .. " + SHIFT + Q",		hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"), { description = "Quit active window and all open instances" })
hl.bind(mainMod .. " + F",				hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Toggle Fullscreen" })
hl.bind(mainMod .. " + M",				hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Toggle Maximize Window" })
hl.bind(mainMod .. " + T",				hl.dsp.window.float({ action = "toggle" }), { description = "Toggle Floating" })
hl.bind(mainMod .. " + J",				hl.dsp.layout("togglesplit"), { description = "Toggle split" })
hl.bind(mainMod .. " + left",			hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind(mainMod .. " + right",			hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
hl.bind(mainMod .. " + up",				hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind(mainMod .. " + down",			hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })
hl.bind(mainMod .. " + SHIFT + right",	hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true }, { description = "Increase window width with keyboard" })
hl.bind(mainMod .. " + SHIFT + left",	hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true }, { description = "Reduce window width with keyboard" })
hl.bind(mainMod .. " + SHIFT + down",	hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true }, { description = "Increase window height with keyboard" })
hl.bind(mainMod .. " + SHIFT + up",		hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true }, { description = "Reduce window height with keyboard" })
hl.bind(mainMod .. " + G",				hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind(mainMod .. " + S",				hl.dsp.workspace.toggle_special("magic"), { description = "Toggle Special WorkSpace" })
hl.bind(mainMod .. " + SHIFT + S",		hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move window to special workspace" })
hl.bind(mainMod .. " + SHIFT + K",		hl.dsp.layout("swapsplit"), { description = "Swapsplit" })
hl.bind(mainMod .. " + ALT + left",		hl.dsp.window.swap({ direction = "l" }), { description = "Swap tiled window left" })
hl.bind(mainMod .. " + ALT + right",	hl.dsp.window.swap({ direction = "r" }), { description = "Swap tiled window right" })
hl.bind(mainMod .. " + ALT + up",		hl.dsp.window.swap({ direction = "u" }), { description = "Swap tiled window up" })
hl.bind(mainMod .. " + ALT + down",		hl.dsp.window.swap({ direction = "d" }), { description = "Swap tiled window down" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down",		hl.dsp.focus({ workspace = "r-1" }), { description = "Switch to next workspace" })
hl.bind(mainMod .. " + mouse_up",		hl.dsp.focus({ workspace = "r+1" }), { description = "Switch to previous workspace" })

-- Mouse drag config
hl.config({
    binds = {
        drag_threshold = 10 -- Fire a drag event only after dragging for more than 10px
    }
})

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272",		hl.dsp.window.drag(),   { mouse = true, description = "Move window with the mouse" })
hl.bind(mainMod .. " + mouse:272",		hl.dsp.window.float({ action = "toggle" }), { mouse = true, click = true, description = "Toggle Floating" })
hl.bind(mainMod .. " + mouse:273",		hl.dsp.window.resize(), { mouse = true, description = "Resize window with the mouse" })
hl.bind(mainMod .. " + mouse:273",		hl.dsp.window.move({ workspace = "special:magic" }), { mouse = true, click = true, description = "Hide to special workspace" })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true, description = "Raise volume" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true, description = "Lower volume" })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true, description = "Mute audio" })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true, description = "Mute microphone" })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true, description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true, description = "Decrease brightness" })

-- Minimize window
hl.bind(mainMod .. " + X", function ()
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
    hl.dispatch(hl.dsp.window.move({workspace = "+0"}))
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
    hl.dispatch(hl.dsp.window.move({workspace = "special:minimize"}))
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
end)

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
end)

-- Zooming
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

hl.bind(mainMod .. " + Z", zoom)
hl.bind(mainMod .. " + KP_ADD", function()
    zoom(0.5)
end)
