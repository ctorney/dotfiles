-- ------------------------------------------------------------------------------------------------
--                          COLOURSCHEME AND SEPARATE PLUGIN FILES
-- ------------------------------------------------------------------------------------------------
vim.pack.add({
	"https://github.com/neanias/everforest-nvim",
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

vim.cmd.colorscheme("everforest")

require("plugins.snacks")
require("plugins.treesitter")

-- ------------------------------------------------------------------------------------------------
--                          UI ELEMENTS - LUALINE, NOICE, WHICHKEY
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	{ src = "https://github.com/ctorney/noice.nvim", version = "feature/south-popup-anchor" },
})

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

require("noice").setup({
  messages = { enabled = false },
	cmdline = {
		view = "cmdline_popup",
		enabled = true,
		format = {
			cmdline = { title = "", pattern = "^:", icon = "", lang = "vim" },
		},
	},
	popupmenu = {
		enabled = true,
		kind_icons = false, 
	},
	notify = {
		enabled = false,
	},
	lsp = {
		progress = {
			enabled = false,
		},
		message = {
			enabled = false,
		},
	},
	presets = {
		command_palette = {
			views = {
				cmdline_popup = {
					position = {
						row = 18,
					},
				},
				cmdline_popupmenu = {
					position = {
						row = 21,
					},
					scrollbar = false,
					size = {
						-- width = 60,
						height = 10, --"auto",
					},
				},
			},
		},
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	views = {
		popupmenu = {
			scrollbar = false,
			size = {
				width = "auto",
				height = "auto",
			},
			border = {
				style = "rounded",
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
			},
		},
	},
})

vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true })

require("which-key").setup({
	-- triggers = {
	-- 	{ "<leader>", mode = { "n", "v" } },
	-- },
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
})

-- ------------------------------------------------------------------------------------------------
--                      UTILITIES - SUBSTITUTE, ESCAPE, CONFORM, FLASH
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	"https://github.com/gbprod/substitute.nvim",
	"https://github.com/max397574/better-escape.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/folke/flash.nvim",
})

require("better_escape").setup()

require("substitute").setup({
	on_substitute = nil,
	yank_substituted_text = false,
	preserve_cursor_position = false,
	modifiers = nil,
	highlight_substituted_text = {
		enabled = true,
		timer = 500,
	},
	range = {
		prefix = "s",
		prompt_current_text = false,
		confirm = false,
		complete_word = false,
		subject = nil,
		range = nil,
		suffix = "",
		auto_apply = false,
		cursor_position = "end",
	},
	exchange = {
		motion = false,
		use_esc_to_cancel = true,
		preserve_cursor_position = false,
	},
})

require("conform").setup({
	notify_on_error = true,
	format_on_save = false,
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "blue" },
		c = { "clang-format" },
		cpp = { "clang-format" },
	},
	ormatters = {
		stylua = {
			prepend_args = { "--column-width", "179" },
		},
	},
})

require("flash").setup({
	jump = { autojump = false },
	modes = {
		char = {
			enabled = true,
			autohide = true,
		},
	},
	highlight = {
		-- show a backdrop with hl FlashBackdrop
		backdrop = false,
	},
})

local keymaps = {
	{
		"gs",
		mode = "n",
		function()
			require("substitute").operator()
		end,
		desc = "Substitute",
	},
	{
		"gs",
		mode = "x",
		function()
			require("substitute").visual()
		end,
		desc = "Substitute",
	},
	{
		"<leader>cf",
		function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end,
		mode = "",
		desc = "[F]ormat buffer",
	},
	{
		"s",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump()
		end,
		desc = "Flash",
	},
	{
		"S",
		mode = { "n", "x", "o" },
		function()
			require("flash").treesitter()
		end,
		desc = "Flash Treesitter",
	},
	-- {
	-- 	"r",
	-- 	mode = "o",
	-- 	function()
	-- 		require("flash").remote()
	-- 	end,
	-- 	desc = "Remote Flash",
	-- },
	-- {
	-- 	"R",
	-- 	mode = { "o", "x" },
	-- 	function()
	-- 		require("flash").treesitter_search()
	-- 	end,
	-- 	desc = "Treesitter Search",
	-- },
	-- {
	-- 	"<c-s>",
	-- 	mode = { "c" },
	-- 	function()
	-- 		require("flash").toggle()
	-- 	end,
	-- 	desc = "Toggle Flash Search",
	-- },
}

for _, map in ipairs(keymaps) do
	local opts = { desc = map.desc }
	if map.silent ~= nil then
		opts.silent = map.silent
	end
	if map.noremap ~= nil then
		opts.noremap = map.noremap
	else
		opts.noremap = true
	end
	if map.expr ~= nil then
		opts.expr = map.expr
	end

	local mode = map.mode or "n"
	vim.keymap.set(mode, map[1], map[2], opts)
end

-- ------------------------------------------------------------------------------------------------
--                            COPILOT - LOADED ON INSERTENTER
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	"https://github.com/zbirenbaum/copilot.lua",
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("InsertEnter", {
			group = vim.api.nvim_create_augroup("copilot", { clear = true }),
			once = true,
			callback = function()
				vim.cmd.packadd("copilot.lua")
				require("copilot").setup({
					suggestion = {
						enabled = true,
						auto_trigger = true,
						keymap = {
							accept = "<S-Right>",
							accept_word = "<S-Down>",
							accept_line = false,
							toggle_auto_trigger = "<C-p>",
							next = "<S-Up>",
							prev = "<C-S-Up>",
							dismiss = "<C-c>",
						},
					},
					panel = {
						enabled = false,
					},
				})
				vim.keymap.set("n", "<leader>tc", function()
					require("copilot.suggestion").toggle_auto_trigger()
				end, { desc = "Toggle copilot autosuggest" })
			end,
		})
	end,
})

-- ------------------------------------------------------------------------------------------------
--                            SLIME - LOADED FOR PYTHON FILES
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	"https://github.com/jpalardy/vim-slime",
	"https://github.com/klafyvel/vim-slime-cells",
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "python", "ipython" },
			group = vim.api.nvim_create_augroup("slime_plugins_lazyload", { clear = false }),
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)

				-- vim-slime config
				if plugin.spec.name == "vim-slime" then
					vim.g.slime_no_mappings = 1
					vim.g.slime_target = "tmux"
					vim.g.slime_default_config = { socket_name = "default", target_pane = "{right}" }
					vim.g.slime_dont_ask_default = 1
					vim.g.slime_bracketed_paste = 1
					vim.keymap.set("n", "<leader>sl", "<cmd>SlimeSendCurrentLine<cr>j", { desc = "Send current line" })
					vim.keymap.set("n", "<leader>sm", "<Plug>SlimeMotionSend", { desc = "Send motion" })
				end

				if plugin.spec.name == "vim-slime-cells" then
					vim.g.slime_cell_delimiter = "^\\s*##"
					vim.keymap.set(
						"n",
						"<S-CR>",
						":call slime_cells#send_cell_and_go_to_next()<CR>zz",
						{ noremap = true, silent = true, desc = "Send cell and go to next" }
					)
					vim.keymap.set(
						"n",
						"<C-CR>",
						":call slime_cells#send_cell_and_go_to_next()<CR>zz",
						{ noremap = true, silent = true, desc = "Send cell and go to next" }
					)
					vim.keymap.set(
						"x",
						"<S-CR>",
						":call slime_cells#send_region()<CR>",
						{ noremap = true, silent = true, desc = "Send region" }
					)
					vim.keymap.set(
						"x",
						"<C-CR>",
						":call slime_cells#send_region()<CR>",
						{ noremap = true, silent = true, desc = "Send region" }
					)
					vim.keymap.set(
						"i",
						"<S-CR>",
						"<C-o>:call slime_cells#send_cell_and_go_to_next()<CR><C-o>zz",
						{ noremap = true, silent = true, desc = "Send cell and go to next" }
					)
					vim.keymap.set(
						"i",
						"<C-CR>",
						"<C-o>:call slime_cells#send_cell_and_go_to_next()<CR><C-o>zz",
						{ noremap = true, silent = true, desc = "Send cell and go to next" }
					)
					vim.keymap.set(
						"n",
						"<leader>cv",
						":call slime_cells#select_current_cell()<CR>",
						{ noremap = true, silent = true, desc = "Select current cell" }
					)
					vim.keymap.set(
						"n",
						"<leader>ss",
						":call slime_cells#send_cell()<CR>",
						{ noremap = true, silent = true, desc = "Send cell" }
					)
					vim.keymap.set(
						"n",
						"<S-Down>",
						":call slime_cells#go_to_next_cell()<CR>zz",
						{ noremap = true, silent = true, desc = "Next cell" }
					)
					vim.keymap.set(
						"n",
						"<S-Up>",
						":call slime_cells#go_to_previous_cell()<CR>zz",
						{ noremap = true, silent = true, desc = "Previous cell" }
					)
				end
			end,
		})
	end,
})
