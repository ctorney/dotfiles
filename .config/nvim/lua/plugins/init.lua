
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
  -- colours_override = function (palette)
  --   palette.blue = "#b86466"
  -- end,

	on_highlights = function(hl, palette)
		hl.NormalFloat = { bg = palette.none }
		hl.FloatBorder = { bg = palette.none, fg = palette.fg }
		hl.FloatTitle = { bg = palette.none }
		hl.Pmenu = { bg = palette.bg_dim }
    hl.PmenuBorder = { fg = palette.bg1, bg = palette.none }
    hl.NoiceCmdlinePopupBorder = { fg = palette.bg1, bg = palette.none }
    hl.NoiceCmdline = { fg = palette.fg, bg = palette.none }
    -- hl.NoicePopupmenuBorder = { fg = palette.bg1, bg = palette.none }
    -- hl.NoicePopupBorder = { fg = palette.bg1, bg = palette.none }
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
	"https://github.com/neanias/everforest-nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/folke/noice.nvim",
})

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = vim.o.laststatus == 3,
		disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
	},
	sections = {
		-- lualine_a = { { "hostname" } },
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
	cmdline = {
		enabled = true, -- enables the Noice cmdline UI
		-- view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
		-- opts = {}, -- global options for the cmdline. See section on views
		---@type table<string, CmdlineFormat>
		format = {
			-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
			-- view: (default is cmdline view)
			-- opts: any options passed to the view
			-- icon_hl_group: optional hl_group for the icon
			-- title: set to anything or empty string to hide
			cmdline = { title = "", pattern = "^:", icon = "", lang = "vim" },
			-- search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
			-- search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			-- filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
			-- lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
			-- help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
			-- input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
			-- lua = false, -- to disable a format, set to `false`
		},
	},
	-- messages = {
	-- 	-- NOTE: If you enable messages, then the cmdline is enabled automatically.
	-- 	-- This is a current Neovim limitation.
	-- 	enabled = true, -- enables the Noice messages UI
	-- 	view = "notify", -- default view for messages
	-- 	view_error = "notify", -- view for errors
	-- 	view_warn = "notify", -- view for warnings
	-- 	view_history = "messages", -- view for :messages
	-- 	view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	-- },
	-- popupmenu = {
	-- 	enabled = true, -- enables the Noice popupmenu UI
	-- 	---@type 'nui'|'cmp'
	-- 	backend = "nui", -- backend to use to show regular cmdline completions
	-- 	---@type NoicePopupmenuItemKind|false
	-- 	-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
	-- 	kind_icons = {}, -- set to `false` to disable icons
	-- },
	-- default options for require('noice').redirect
	-- see the section on Command Redirection
	---@type NoiceRouteConfig
	-- redirect = {
	-- 	view = "popup",
	-- 	filter = { event = "msg_show" },
	-- },
	-- You can add any custom commands below that will be available with `:Noice command`
	---@type table<string, NoiceCommand>
	-- commands = {
	-- 	history = {
	-- 		-- options for the message history that you get with `:Noice`
	-- 		view = "split",
	-- 		opts = { enter = true, format = "details" },
	-- 		filter = {
	-- 			any = {
	-- 				{ event = "notify" },
	-- 				{ error = true },
	-- 				{ warning = true },
	-- 				{ event = "msg_show", kind = { "" } },
	-- 				{ event = "lsp", kind = "message" },
	-- 			},
	-- 		},
	-- 	},
	-- 	-- :Noice last
	-- 	-- last = {
	-- 	-- 	view = "popup",
	-- 	-- 	opts = { enter = true, format = "details" },
	-- 	-- 	filter = {
	-- 	-- 		any = {
	-- 	-- 			{ event = "notify" },
	-- 	-- 			{ error = true },
	-- 	-- 			{ warning = true },
	-- 	-- 			{ event = "msg_show", kind = { "" } },
	-- 	-- 			{ event = "lsp", kind = "message" },
	-- 	-- 		},
	-- 	-- 	},
	-- 	-- 	filter_opts = { count = 1 },
	-- 	-- },
	-- 	-- :Noice errors
	-- 	-- errors = {
	-- 	-- 	-- options for the message history that you get with `:Noice`
	-- 	-- 	view = "popup",
	-- 	-- 	opts = { enter = true, format = "details" },
	-- 	-- 	filter = { error = true },
	-- 	-- 	filter_opts = { reverse = true },
	-- 	-- },
	-- 	-- all = {
	-- 	-- 	-- options for the message history that you get with `:Noice`
	-- 	-- 	view = "split",
	-- 	-- 	opts = { enter = true, format = "details" },
	-- 	-- 	filter = {},
	-- 	-- },
	-- },
	notify = {
		-- Noice can be used as `vim.notify` so you can route any notification like other messages
		-- Notification messages have their level and other properties set.
		-- event is always "notify" and kind can be any log level as a string
		-- The default routes will forward notifications to nvim-notify
		-- Benefit of using Noice for this is the routing and consistent history view
		enabled = false,
		view = "notify",
	},
	lsp = {
		progress = {
			enabled = false,
			-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
			-- See the section on formatting for more details on how to customize.
			--- @type NoiceFormat|string
			format = "lsp_progress",
			--- @type NoiceFormat|string
			format_done = "lsp_progress_done",
			throttle = 1000 / 30, -- frequency to update lsp progress message
			view = "mini",
		},
		override = {
			-- override the default lsp markdown formatter with Noice
			["vim.lsp.util.convert_input_to_markdown_lines"] = false,
			-- override the lsp markdown formatter with Noice
			["vim.lsp.util.stylize_markdown"] = false,
			-- override cmp documentation with Noice (needs the other options to work)
			["cmp.entry.get_documentation"] = false,
		},
		hover = {
			enabled = true,
			silent = false, -- set to true to not show a message if hover is not available
			view = nil, -- when nil, use defaults from documentation
			---@type NoiceViewOptions
			opts = {}, -- merged with defaults from documentation
		},
		signature = {
			enabled = true,
			auto_open = {
				enabled = true,
				trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
				luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
				throttle = 50, -- Debounce lsp signature help request by 50ms
			},
			view = nil, -- when nil, use defaults from documentation
			---@type NoiceViewOptions
			opts = {}, -- merged with defaults from documentation
		},
		message = {
			-- Messages shown by lsp servers
			enabled = false,
			view = "notify",
			opts = {},
		},

		-- defaults for hover and signature help
	-- 	documentation = {
	-- 		view = "hover",
	-- 		---@type NoiceViewOptions
	-- 		opts = {
	-- 			lang = "markdown",
	-- 			replace = true,
	-- 			render = "plain",
	-- 			format = { "{message}" },
	-- 			win_options = { concealcursor = "n", conceallevel = 3 },
	-- 		},
	-- 	},
	-- },
	-- markdown = {
	-- 	hover = {
	-- 		["|(%S-)|"] = vim.cmd.help, -- vim help links
	-- 		["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
	-- 	},
	-- 	highlights = {
	-- 		["|%S-|"] = "@text.reference",
	-- 		["@%S+"] = "@parameter",
	-- 		["^%s*(Parameters:)"] = "@text.title",
	-- 		["^%s*(Return:)"] = "@text.title",
	-- 		["^%s*(See also:)"] = "@text.title",
	-- 		["{%S-}"] = "@parameter",
	-- 	},
	},
	health = {
		checker = true, -- Disable if you don't want health checks to run
	},
	---@type NoicePresets
	presets = {
	-- 	-- you can enable a preset by setting it to true, or a table that will override the preset config
	-- 	-- you can also add custom presets that you can enable/disable with enabled=true
	-- 	bottom_search = false, -- use a classic bottom cmdline for search
		-- command_palette = true, -- position the cmdline and popupmenu together
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
        },scrollbar = false,
			size = {
				-- width = 60,
				height = 10,--"auto",
			},
      },
    },
  },
	-- 	long_message_to_split = false, -- long messages will be sent to a split
	-- 	inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	-- throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
	views = {
	-- 	cmdline_popup = {
	-- 		border = {
	-- 			style = "rounded",
	-- 			padding = { 0, 1 },
	-- 		},
	-- 		filter_options = {},
	-- 		win_options = {
	-- 			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
	-- 		},
	-- 		-- position = {
	-- 		-- 	row = "40%",
	-- 		-- 	col = "50%",
	-- 		-- },
	-- 		-- size = {
	-- 		-- 	-- width = 60,
	-- 		-- 	height = "auto",
	-- 		-- },
	-- 	},
		popupmenu = {scrollbar = false,
			-- relative = "editor",
			-- position = {
			-- 	row = "52%",
			-- 	col = "50%",
			-- },
			size = {
				width = "auto",
				-- height = 10,
			},
			border = {
				style = "rounded",
				padding = { 0, 1 },
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
	triggers = {
		{ "<leader>", mode = { "n", "v" } },
	},
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
	-- {
	-- 	"S",
	-- 	mode = { "n", "x", "o" },
	-- 	function()
	-- 		require("flash").treesitter()
	-- 	end,
	-- 	desc = "Flash Treesitter",
	-- },
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
