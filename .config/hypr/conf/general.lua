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
		new_status = "master",
		new_on_top=1,
		mfact = 0.5,
	},
	scrolling = {
		fullscreen_on_one_column = true,
	},
})
