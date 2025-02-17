return {
	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		opts = {
			filetypes = {
				markdown = true,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<S-Right>",
					accept_word = "<S-Down>",
					accept_line = false,
					next = "<S-Up>",
					prev = "<C-S-Up>",
					dismiss = "<C-c>",
				},
			},
			panel = {
				enabled = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<C-p>",
				},
			},
		},
	},
	{
		"jpalardy/vim-slime",
		lazy = false,
		ft = { "python", "lua", "sh", "zsh", "bash", "ipython", "markdown" },
		config = function()
			vim.g.slime_target = "tmux"
			-- vim.g.slime_config = { socket_name = "default", target_pane = "{right}" }
			vim.g.slime_default_config = { socket_name = "default", target_pane = "{right}" }
			vim.g.slime_dont_ask_default = 1
			vim.g.slime_bracketed_paste = 1
			vim.g.slime_no_mappings = 1

			vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>SlimeSendCurrentLine<cr>j", { desc = "Send current line" })
		end,
	},

	{
		"klafyvel/vim-slime-cells",
		requires = { { "jpalardy/vim-slime", opt = true } },
		ft = { "python", "ipython", "lua", "sh", "zsh", "bash", "markdown" },
		config = function()
			vim.g.slime_cell_delimiter = "^\\s*##"

			vim.cmd([[
        nmap <S-CR> <Plug>SlimeCellsSendAndGoToNext
        nmap <C-CR> <Plug>SlimeCellsSendAndGoToNext
        xmap <S-CR> <Plug>SlimeRegionSend
        xmap <C-CR> <Plug>SlimeRegionSend
        imap <S-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        imap <C-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        nmap <leader>cv <Plug>Slimeconfig
        nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>sc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>ss <Plug>SlimeCellsSend
        nmap <S-Down> <Plug>SlimeCellsNext
        nmap <S-Up> <Plug>SlimeCellsPrev
        ]])
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
	},
	{
		"echasnovski/mini.diff",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			source = {
				attach = function()
					return false
				end,
			},
			mappings = {
				-- Apply hunks inside a visual/operator region
				apply = "",

				-- Reset hunks inside a visual/operator region
				reset = "",

				-- Hunk range textobject to be used inside operator
				-- Works also in Visual mode if mapping differs from apply and reset
				textobject = "",

				-- Go to hunk range in corresponding direction
				goto_first = "",
				goto_prev = "",
				goto_next = "",
				goto_last = "",
			},
		},
		enabled = true,
	},
	{
		"olimorris/codecompanion.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.diff",
		},
		config = true,
		opts = {
			display = {
				chat = {
					window = { layout = "float", title = " Code Companion " },
					start_in_insert_mode = true,
				},
				diff = {
					provider = "mini_diff",
				},
			},
			strategies = {
				chat = {
					roles = {
						user = "Human",
					},
					adapter = "anthropic",
					keymaps = {
						hide = {
							modes = {
								n = { "q", "<esc>", "<BS>" },
							},
							callback = function(chat)
								chat.ui:hide()
							end,
							description = "Hide the chat buffer",
						},
					},
				},
				inline = {
					adapter = "anthropic",
					keymaps = {
						accept_change = {
							modes = {
								n = "a",
							},
							index = 1,
							callback = "keymaps.accept_change",
							description = "Accept change",
						},
						reject_change = {
							modes = {
								n = "r",
							},
							index = 2,
							callback = "keymaps.reject_change",
							description = "Reject change",
						},
					},
				},
			},
		},
		keys = {
			{ "<leader>i", ":'<,'>CodeCompanion<cr>", desc = "Inline code companion", mode = { "v" }, silent = true },
			{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
			{ "gt", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
			{ "<c-p>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v", "i" } },
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Toggle actions companion", mode = { "n", "v" } },
		},
	},
	{ "milanglacier/yarepl.nvim", config = true },
}
