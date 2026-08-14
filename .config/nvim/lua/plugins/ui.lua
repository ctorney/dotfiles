
-- ------------------------------------------------------------------------------------------------
--                          COLOURSCHEME AND SEPARATE PLUGIN FILES
-- ------------------------------------------------------------------------------------------------
vim.pack.add({
	"https://github.com/neanias/everforest-nvim",
  "https://github.com/wtfox/luna.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
})

require("everforest").setup({
	background = "hard",
	transparent_background_level = 2,
	float_style = "dim",

	on_highlights = function(hl, palette)
		hl.NormalFloat = { bg = palette.none }
		hl.FloatBorder = { bg = palette.none, fg = palette.bg1 }
		hl.FloatTitle = { bg = palette.none }
		hl.Pmenu = { bg = palette.none, fg = palette.fg }
		hl.PmenuBorder = { fg = palette.bg1, bg = palette.none }
		hl.NoiceCmdlinePopupBorder = { fg = palette.bg1, bg = palette.none }
		hl.NoiceCmdline = { fg = palette.fg, bg = palette.none }
	end,
})


require("luna").setup({
  transparent = true
})

vim.cmd.colorscheme("luna")
require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = vim.o.laststatus == 3,
		disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
	},
	sections = {
		lualine_a = { { "mode" } },
		lualine_b = { { "" } },

		lualine_c = {
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			{ "filename", path = 3, file_status = false },
		},
		lualine_x = {
			{ "location", padding = { left = 1, right = 1 } },
		},
		lualine_y = {
			{ "progress", padding = { left = 1, right = 1 } },
		},
		lualine_z = { { "hostname" } },
	},
})
