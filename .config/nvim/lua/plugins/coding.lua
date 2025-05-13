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
	{
		"klafyvel/vim-slime-cells",
		ft = { "python" },
		config = function()
			vim.g.slime_cell_delimiter = "^\\s*# %%"

			vim.cmd([[
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
	{
		"milanglacier/yarepl.nvim",
		opts = function(_, opts)
			opts.buflisted = false
			opts.scratch = true
			opts.ft = "REPL"

			opts.wincmd = function(bufnr, name)
				-- Create the split and get the new window ID
				vim.cmd("vertical rightbelow split")
				local new_win = vim.api.nvim_get_current_win()

				-- Set the buffer in the new window
				vim.api.nvim_win_set_buf(new_win, bufnr)

				-- -- Set the width of the new window
				local width = math.floor(vim.o.columns * 0.30)
				vim.cmd("vertical resize " .. width)

				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				vim.cmd("startinsert")
			end

			opts.metas = {
				aichat = false,
				radian = false,
				ipython = {
					cmd = {
						"ipython",
						"-i",
						"-c",
						'\'import matplotlib;matplotlib.use("module://matplotlib-backend-nvim");matplotlib.rc("figure", figsize=(10, 6));from qbstyles import mpl_style;mpl_style("dark")\'',
					},
					formatter = "bracketed_pasting",
				},
				python = false,
				R = false,
				bash = false,
				zsh = false,
			}
			opts.close_on_exit = true
			opts.scroll_to_bottom_after_sending = false
			opts.format_repl_buffers_names = true
			vim.keymap.set(
				"n",
				"<leader>rq",
				"<cmd>REPLClose<cr>",
				{ noremap = true, silent = true, desc = "Close the current REPL" }
			)
			vim.keymap.set(
				"n",
				"<leader>ra",
				"<cmd>REPLAttachBufferToREPL<cr>",
				{ noremap = true, silent = true, desc = "Attach current buffer to a REPL" }
			)
			vim.keymap.set(
				"v",
				"<leader>sv",
				"<cmd>REPLSendVisual<cr>",
				{ noremap = true, silent = true, desc = "Send code to REPL" }
			)
			vim.keymap.set(
				"n",
				"<leader>sl",
				"<cmd>REPLSendLine<cr>",
				{ noremap = true, silent = true, desc = "Send line to REPL" }
			)
			vim.keymap.set(
				"n",
				"<leader>sf",
				"ggvG<cmd>REPLSendVisual<cr>",
				{ noremap = true, silent = true, desc = "Send file to REPL" }
			)
			vim.keymap.set(
				"n",
				"<leader>so",
				"<cmd>REPLSendOperator<cr>",
				{ noremap = true, silent = true, desc = "Send motion to REPL" }
			)
			vim.keymap.set(
				"n",
				"<C-CR>",
				"<cmd>REPLSendOperator<cr>ihg]hjj",
				{ desc = "Send visual selection to REPL", remap = true }
			)
			vim.keymap.set(
				"i",
				"<C-CR>",
				"<Esc><cmd>REPLSendOperator<cr>ihg]hjji",
				{ desc = "Send visual selection to REPL", remap = true }
			)
		end,
		keys = {
			{ "<leader>rp", "<cmd>REPLStart ipython<cr><cmd>wincmd h<cr>", desc = "Start an ipython REPL" },
		},
	},
}
