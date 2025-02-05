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
				float_style = "none",
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
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = false, -- long messages will be sent to a split
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		init = function()
			vim.g.lsp_handlers_enabled = false
		end,
	},
-- 	{
-- 		"goolord/alpha-nvim",
-- 		event = "VimEnter",
-- 		config = function()
-- 			local alpha = require("alpha")
-- 			local dashboard = require("alpha.themes.dashboard")
--
-- 			-- Set header
-- 			dashboard.section.header.val = {
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"",
-- 				"                                                     ",
-- 				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
-- 				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
-- 				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
-- 				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
-- 				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
-- 				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
-- 				"                                                     ",
-- 			}
--
-- 			-- Set menu
-- 			dashboard.section.buttons.val = {
-- 				dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
-- 				dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
-- 				dashboard.button("c", "  > Config", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
-- 				dashboard.button("q", "  > Quit", ":qa<CR>"),
-- 			}
--
-- 			-- Send config to alpha
-- 			alpha.setup(dashboard.opts)
--
-- 			-- Disable folding on alpha buffer
-- 			vim.cmd([[
--     autocmd FileType alpha setlocal nofoldenable
-- ]])
-- 		end,
-- 	},
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
	{
		"akinsho/bufferline.nvim",
		opts = { options = { indicator = { style = "none" }, separator_style = "thin", show_tab_indicators = false } },
	},
}
