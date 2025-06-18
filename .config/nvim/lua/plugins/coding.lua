return {
	{
		"zbirenbaum/copilot.lua",
		event = { "BufReadPre", "BufNewFile" },
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
--   {
--   "jpalardy/vim-slime",
--   init = function()
--     -- these two should be set before the plugin loads
--     vim.g.slime_target = "neovim"
--     vim.g.slime_no_mappings = true
--   end,
--   config = function()
--     vim.g.slime_input_pid = false
--     vim.g.slime_suggest_default = true
--     vim.g.slime_menu_config = false
--     vim.g.slime_neovim_ignore_unlisted = false
--     -- options not set here are g:slime_neovim_menu_order, g:slime_neovim_menu_delimiter, and g:slime_get_jobid
--     -- see the documentation above to learn about those options
--
--     -- called MotionSend but works with textobjects as well
--     vim.keymap.set("n", "gz", "<Plug>SlimeMotionSend", { remap = true, silent = false })
--     vim.keymap.set("n", "gzz", "<Plug>SlimeLineSend", { remap = true, silent = false })
--     vim.keymap.set("x", "gz", "<Plug>SlimeRegionSend", { remap = true, silent = false })
--     vim.keymap.set("n", "gzc", "<Plug>SlimeConfig", { remap = true, silent = false })
--   end,
-- },
{
    "jpalardy/vim-slime",
    ft = { "python", "lua", "sh", "zsh", "bash", "ipython", "markdown" },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{right}" }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1

      vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>SlimeSendCurrentLine<cr>j", { desc = "Send current line" })
      vim.api.nvim_set_keymap("n", "<leader>sm", "<Plug>SlimeMotionSend", { desc = "Send motion" })
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
		"Davidyz/VectorCode",
		version = "*", -- optional, depending on whether you're on nightly or release
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "VectorCode", -- if you're lazy-loading VectorCode
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.diff",
		},
		opts = {
			extensions = {
				vectorcode = {
					opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
				},
			},
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
					adapter = "gemini",
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
						send = {
							modes = {
								n = { "<CR>", "<C-s>" },
								i = { "<CR>", "<C-s>" },
							},
						},
					},
				},
				inline = {
					adapter = "gemini",
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
			adapters = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						-- env = {
						-- 				api_key = "ANTHROPIC_API_KEY",
						-- 			},
						schema = {
							-- 				---@type CodeCompanion.Schema
							model = {
								order = 1,
								mapping = "parameters",
								type = "enum",
								desc = "The model that will complete your prompt. See https://docs.anthropic.com/claude/docs/models-overview for additional details and options.",
								default = "claude-3-7-sonnet-20250219",
								choices = {
									["claude-3-7-sonnet-20250219"] = { opts = { can_reason = false } },
									"claude-3-5-sonnet-20241022",
									"claude-3-5-haiku-20241022",
									"claude-3-opus-20240229",
									"claude-2.1",
								},
							},
						},
					})
				end,
			},
		},
		keys = {
			{ "<leader>i", ":'<,'>CodeCompanion<cr>", desc = "Inline code companion", mode = { "v" }, silent = true },
			{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
			{ "gt", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Toggle actions companion", mode = { "n", "v" } },
		},
	},
	
}
