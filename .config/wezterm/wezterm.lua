local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end


local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

-- wezterm.on("gui-startup", function()
-- 	local tab, pane, window = mux.spawn_window({})
-- 	-- pane:split { direction = 'Top' }
-- 	window:gui_window():maximize()
-- end)
-- -- The filled in variant of the < symbol

-- -- This function returns the suggested title for a tab.
-- -- It prefers the title that was set via `tab:set_title()`
-- -- or `wezterm cli set-tab-title`, but falls back to the
-- -- title of the active pane in that tab.
-- function tab_title(tab_info)
--   local title = tab_info.tab_title
--   -- if the tab title is explicitly set, take that
--   -- Otherwise, use the title from the active pane
--   -- in that tab
--   -- get the name of the process running in the active pane
--   local process_name = tab_info.active_pane.foreground_process_name
--   -- split the process name by / and get the last element
--   process_name = process_name:match("([^/]+)$")
--   -- if the process name is empty, use the title of the active pane
--   if process_name == "" then
--     return tab_info.active_pane.title
--   end
--
--   return " " .. process_name .. " - " .. tab_info.active_pane.title
--   --return " " .. process_name .. " "
-- end
--
-- wezterm.on(
--   'format-tab-title',
--   function(tab, tabs, panes, config, hover, max_width)
--     local edge_background = 'rgba(0,0,0,0.9)'
--     local edge_foreground = '#3c4841'
--     local background = 'rgba(0,0,0,0.9)'
--     local foreground = '#9da9a0'
--     local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_forwardslash_separator
--     local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_forwardslash_separator
--
--     if tab.is_active then
--     foreground = '#e67e80'
--       background = 'rgba(0,0,0,0.9)'
--       edge_foreground = '#d3c6aa'
-- SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
--     elseif hover then
--       background = '#000000'
--       foreground = '#ffffff'
--       edge_foreground = '#a7c080'
-- SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
--     end
--
--
--     local title = tab_title(tab)
--
--     -- ensure that the titles fit in the available space,
--     -- and that we have room for the edges.
--     -- title = wezterm.truncate_right(title, max_width - 2)
--
--     return {
--       { Background = { Color = edge_background } },
--       { Foreground = { Color = edge_foreground } },
--       { Text = "|" },
--       { Background = { Color = background } },
--       { Foreground = { Color = foreground } },
--       { Text = title },
--       { Background = { Color = edge_background } },
--       { Foreground = { Color = edge_foreground } },
--       { Text = " " },
--     }
--   end
-- )



local set_environment_variables = {
  PATH = wezterm.home_dir .. '/.cargo/bin:' .. os.getenv('PATH')
}

keys = {
 {
      key = 'n',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.DisableDefaultAssignment,
    },
	{
		key = "e",
		mods = "CTRL",
		action = act.CloseCurrentPane({ confirm = false }),
	},
  {
    key = "Tab",
    mods = "CTRL",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "l",
    mods = "CTRL",
    action = act.ActivatePaneDirection "Right",
  },
  {
    key = "h",
    mods = "CTRL",
    action = act.ActivatePaneDirection "Left",
  },
  {
    key = "j",
    mods = "CTRL",
    action = act.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "CTRL",
    action = act.ActivatePaneDirection "Up",
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "/",
    mods = "LEADER",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.ShowTabNavigator,
  },
  {
    key = "d",
    mods = "LEADER",
    action = act.DetachDomain "CurrentPaneDomain",
  },
  {
    key = "n",
    mods = "LEADER",
    action = act.SpawnWindow
  },
  {
    key = "t",
    mods = "LEADER",
    action = act.SpawnTab "CurrentPaneDomain",
  },
  {
    key = "p",
    mods = "LEADER",
    action = act.SplitPane {
      direction = 'Right', 
      size = {Percent = 30}, 
      command = {
        args = {'bash'},
        set_environment_variables = {MYPATH = PATH},
      },
    },
  },

    -- move between split panes
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
    -- resize panes
    split_nav('resize', 'h'),
    split_nav('resize', 'j'),
    split_nav('resize', 'k'),
    split_nav('resize', 'l'),

}

mouse_bindings = {
    -- Change the default click behavior so that it populates
    -- the Clipboard rather the PrimarySelection.
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
    },
  -- {
  --   event = { Up = { streak = 1, button = 'Middle' } },
  --   mods = 'NONE',
  --   action = act.PasteFrom 'Clipboard',
  -- },
  -- {
  --   event = { Down = { streak = 1, button = 'Middle' } },
  --   mods = 'NONE',
  --   action = act.Nop,
  -- },
}


config = {
  leader = { key = "b", mods = "CTRL" },
  window_background_opacity = 0.80,
  audible_bell = "Disabled",

	warn_about_missing_glyphs = false,
	scrollback_lines = 1000,
  enable_wayland = false,
	-- front_end = "WebGpu",
	enable_csi_u_key_encoding = true,
	window_decorations = "NONE",
  use_ime = true,

	-- color_scheme = "Everforest Dark (Gogh)",
	-- color_scheme = "flexoki-dark",
  color_scheme = 'Neon (terminal.sexy)',
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	-- colors = {cursor_bg = "#A7C080", cursor_fg = "#1E2326"},
	colors = { cursor_bg = "#D3C6AA", cursor_fg = "#1E2326" , background = "01010A"},
	-- font = wezterm.font("Hack Nerd Font"),
  font = wezterm.font("VictorMono Nerd Font"),
  -- font = wezterm.font("BigBlueTerm437 Nerd Font"),
	-- font = wezterm.font("Iosevka Nerd Font"),

  -- font = wezterm.font_with_fallback({
         -- "Hack",
         -- "Symbols Nerd Font Mono"
   -- }),
inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
},
	font_size = 11,
	line_height = 1.0,
	adjust_window_size_when_changing_font_size = false,
	exit_behavior = "Close",
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = true,
  use_fancy_tab_bar = true,
  tab_bar_at_bottom = false,
  window_padding = {
    left = 20,
    right = 5,
    top = 20,
    bottom = 2,
  },
  disable_default_key_bindings = false,
  window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'Hack Nerd Font', weight = 'Regular' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 10.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = 'rgba(50,50,50,0.9)',


  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = 'rgba(0,0,0,0.9)',


},
    show_new_tab_button_in_tab_bar = false,
  send_composed_key_when_left_alt_is_pressed = true,

	-- default_prog = { 'tmux' },

	-- background = {
	-- 	{
	-- 		source = { File = wezterm.home_dir .. "/.config/wezterm/wallpaper.jpg" },
	-- 		hsb = { hue = 1.0, saturation = 1.0, brightness = 0.05 },
	-- 	},
	-- },

	keys = keys,
  -- mouse_bindings = mouse_bindings,
}
