return {
	{
		"neanias/everforest-nvim",
    version = "*",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("everforest").setup({
				background = "hard",
				transparent_background_level = 2,
				float_style = "dim",
				on_highlights = function(hl, palette)
					--      hl.Normal = { bg = palette.bg,fg = palette.fg }
					hl.NormalFloat = { bg = palette.none }
					--      hl.exdarkbg = { bg = palette.bg_dim, fg = palette.fg }
					hl.FloatBorder = { bg = palette.none }
					hl.FloatTitle = { bg = palette.none }
					hl.MiniDiffOverAdd = { fg = palette.blue, bg = palette.bg_dim }
					hl.MiniDiffOverDelete = { fg = palette.red, bg = palette.bg_dim }
					hl.MiniDiffOverChange = { fg = palette.blue, bg = palette.bg_dim }
					hl.DiffChange = { fg = palette.grey0, bg = palette.none }
				end,
			})
			-- Load the colorscheme AFTER setup is complete
			vim.cmd.colorscheme("everforest")
      vim.api.nvim_set_hl(0, "added", { fg = "#e67e80", bg = "#000000", bold = true })
      vim.api.nvim_set_hl(0, "removed", { fg = "#a7c080", bg = "#000000", bold = true })
		end,
	},
	{
		"folke/noice.nvim",
    version = "*",
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
    enabled = false,
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
