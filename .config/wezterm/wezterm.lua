local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- this is called by the mux server when it starts up.
-- It makes a window split top/bottom
wezterm.on("mux-startup", function()
	local tab, pane, window = mux.spawn_window({})
	-- window:maximize()
	window:mux_window():maximize()
end)

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	-- pane:split { direction = 'Top' }
	window:gui_window():maximize()
end)

inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

keys = {
	{
		key = "e",
		mods = "CTRL",
		action = act.CloseCurrentPane({ confirm = false }),
	},
}

return {
	unix_domains = {
		{ name = "unix" },
	},
	ssh_domains = {
		{ name = "euclid.35", remote_address = "euclid-35.maths.gla.ac.uk", username = "ctorney" },
	},

	warn_about_missing_glyphs = false,
	scrollback_lines = 0,
	front_end = "OpenGL",
	enable_csi_u_key_encoding = true,
	window_decorations = "RESIZE",
	-- color_scheme = 'Hardcore',
	color_scheme = "Everforest Dark (Gogh)",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	-- colors = {cursor_bg = "#A7C080", cursor_fg = "#1E2326"},
	colors = { cursor_bg = "#D3C6AA", cursor_fg = "#1E2326" },
	font = wezterm.font("Hack Nerd Font"),
	font_size = 11,
	line_height = 1.0,
	adjust_window_size_when_changing_font_size = false,
	exit_behavior = "Close",
	hide_tab_bar_if_only_one_tab = false,
	enable_tab_bar = false,
	-- default_prog = { 'tmux' },

	background = {
		{
			source = { File = wezterm.home_dir .. "/.config/wezterm/wallpaper.jpg" },
			hsb = { hue = 1.0, saturation = 1.0, brightness = 0.05 },
		},
	},

	keys = keys,
}
