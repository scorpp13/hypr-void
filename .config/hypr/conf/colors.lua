require("hyprcolors")

hl.config({
    general = {
        col = {
            active_border   = active_border,
            inactive_border = inactive_border,
        },
    },
    misc = {
        background_color = background_color,
    },
})

hl.window_rule({
    match        = { pin = 1 },
    border_color = border_color,
})
