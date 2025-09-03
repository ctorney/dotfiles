return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("everforest")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
		config = function()
			require("everforest").setup({
				background = "hard",
				transparent_background_level = 2,
				float_style = "dim",
				on_highlights = function(hl, palette)
					hl.NormalFloat = { bg = palette.none }
					hl.FloatBorder = { bg = palette.none }
					hl.FloatTitle = { bg = palette.none }
					hl.MiniDiffOverAdd = { fg = palette.blue, bg = palette.bg_dim }
					hl.MiniDiffOverDelete = { fg = palette.red, bg = palette.bg_dim }
					hl.MiniDiffOverChange = { fg = palette.blue, bg = palette.bg_dim }
					hl.DiffChange = { fg = palette.grey0, bg = palette.none }
					-- hl.BlinkCmpSignatureHelpBorder = { fg = palette.grey0, bg = palette.red }
				end,
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = false,
				long_message_to_split = true,
				lsp_doc_border = false,
			},
		},
		init = function()
			vim.g.lsp_handlers_enabled = false
		end,
	},
	-- {
	-- 	"echasnovski/mini.hipatterns",
	-- 	version = false,
	-- 	opts = function()
	-- 		return {
	-- 			highlighters = {
	-- 				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
	-- 				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
	-- 				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
	-- 				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
	-- 				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
	--
	-- 				-- Highlight hex color strings (`#rrggbb`) using that color
	-- 				hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
	-- 			},
	-- 		}
	-- 	end,
	-- },

	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {
			hide_target_hack = true,
			cursor_color = "none",
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			win = {
				no_overlap = false,
				height = { min = 4, max = 50 },
				padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
				title = true,
				title_pos = "center",
				zindex = 1000,
			},
			wo = {
				winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			},
		},
	},
	-- {
	-- 	"utilyre/barbecue.nvim",
	-- 	name = "barbecue",
	-- 	version = "*",
	-- 	dependencies = {
	-- 		"SmiteshP/nvim-navic",
	-- 		"nvim-tree/nvim-web-devicons", -- optional dependency
	-- 	},
	-- 	opts = {
	-- 		-- configurations go here
	-- 	},
	-- },
	{
		"akinsho/bufferline.nvim",
		enabled = false,
		event = { "BufRead", "BufNewFile" },
		opts = {
			options = {
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				show_close_icon = false,
				show_buffer_close_icons = false,
				indicator = { style = "icon" },
				separator_style = "thin",
				show_tab_indicators = false,
				always_show_bufferline = true,
				custom_filter = function(buf_number)
					-- filter out filetypes you don't want to see
					if vim.bo[buf_number].filetype ~= "codecompanion" then
						return true
					end
				end,
			},
		},
	},
}
