hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 6,
		border_size = 2,
		layout = "dwindle", -- master scrolling monocle
		resize_on_border = true,
	},
	dwindle = {
		preserve_split = true, -- you probably want this
	},
	master = {
		mfact = 0.5, --default 0.55
	},
	binds = {
		drag_threshold = 10, -- Fire a drag event only after dragging for more than 10px
		allow_workspace_cycles = true,
	},
})
