return {
	{
		"vimpostor/vim-tpipeline",
		dependencies = "nvim-lualine/lualine.nvim",
		enabled = true,
		event = "VeryLazy",
		init = function()
			vim.g.tpipeline_restore = 1
		end,
	},
	{

		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				vim.o.statusline = " "
			else
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			local icons = require("config.icons")
			vim.o.laststatus = vim.g.lualine_laststatus

			local opts = {
				options = {
					theme = "auto",
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
				},
				sections = {
					lualine_a = { { "hostname" } },
					lualine_b = { { "mode" } },

					lualine_c = {
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 3, file_status = false },
					},
					lualine_x = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						-- {
						-- 	"buffers",
						-- 	cond = function()
						-- 		return #vim.fn.getbufinfo({ buflisted = 1 }) > 1
						-- 	end,
						-- 	mode = 0,
						-- 	icons_enabled = true,
						-- 	symbols = {
						-- 		modified = " ●", -- Text to show when the buffer is modified
						-- 		alternate_file = "", -- Text to show to identify the alternate file
						-- 		directory = "", -- Text to show when the buffer is a directory
						-- 	},
						-- },
						{

							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = function()
								return { fg = Snacks.util.color("Special") }
							end,
						},
					},
					lualine_y = {
						{ "location", padding = { left = 1, right = 1 } },
						{ "progress", padding = { left = 1, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "lazy", "fzf" },
			}

			return opts
		end,
	},
}
