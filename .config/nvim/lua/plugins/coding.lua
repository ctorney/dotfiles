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
	-- {
	-- 	"jpalardy/vim-slime",
	-- 	lazy = false,
	-- 	ft = { "python", "lua", "sh", "zsh", "bash", "ipython", "markdown" },
	-- 	config = function()
	-- 		vim.g.slime_target = "tmux"
	-- 		-- vim.g.slime_config = { socket_name = "default", target_pane = "{right}" }
	-- 		vim.g.slime_default_config = { socket_name = "default", target_pane = "{right}" }
	-- 		vim.g.slime_dont_ask_default = 1
	-- 		vim.g.slime_bracketed_paste = 1
	-- 		vim.g.slime_no_mappings = 1
	--
	-- 		vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>SlimeSendCurrentLine<cr>j", { desc = "Send current line" })
	-- 	end,
	-- },
	--
	-- {
	-- 	"klafyvel/vim-slime-cells",
	-- 	requires = { { "jpalardy/vim-slime", opt = true } },
	-- 	ft = { "python", "ipython", "lua", "sh", "zsh", "bash", "markdown" },
	-- 	config = function()
	-- 		vim.g.slime_cell_delimiter = "^\\s*##"
	--
	-- 		vim.cmd([[
	--        nmap <S-CR> <Plug>SlimeCellsSendAndGoToNext
	--        nmap <C-CR> <Plug>SlimeCellsSendAndGoToNext
	--        xmap <S-CR> <Plug>SlimeRegionSend
	--        xmap <C-CR> <Plug>SlimeRegionSend
	--        imap <S-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
	--        imap <C-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
	--        nmap <leader>cv <Plug>Slimeconfig
	--        nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
	--        nmap <leader>sc <Plug>SlimeCellsSendAndGoToNext
	--        nmap <leader>ss <Plug>SlimeCellsSend
	--        nmap <S-Down> <Plug>SlimeCellsNext
	--        nmap <S-Up> <Plug>SlimeCellsPrev
	--        ]])
	-- 	end,
	-- },
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
	{
		"milanglacier/yarepl.nvim",
		dependencies = { "echasnovski/mini.ai" },
		opts = function(_, opts)
			-- see `:h buflisted`, whether the REPL buffer should be buflisted.
			opts.buflisted = false
			-- whether the REPL buffer should be a scratch buffer.
			opts.scratch = true
			-- the filetype of the REPL buffer created by `yarepl`
			opts.ft = "REPL"
			-- How yarepl open the REPL window, can be a string or a lua function.
			-- See below example for how to configure this option
			-- opts.wincmd = "vertical 30 split"

			-- opts.wincmd = function(bufnr, name)
			-- 	vim.api.nvim_open_win(bufnr, false, {
			-- 		-- relative = "editor",
			-- 		-- row = math.floor(vim.o.lines * 0.01),
			-- 		-- col = math.floor(vim.o.columns * 0.75),
			-- 		-- width = math.floor(vim.o.columns * 0.25),
			-- 		-- height = math.floor(vim.o.lines * 0.98),
			-- 		style = "minimal",
			-- 		-- title = "",
			-- 		-- border = "rounded",
			-- 		-- title_pos = "center",
			-- 	})
			-- end

			opts.wincmd = function(bufnr, name)
				-- Store the current window ID before splitting
				local current_win = vim.api.nvim_get_current_win()

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
				-- Start terminal in insert mode
				vim.cmd("startinsert")
				-- Return focus to the original window
				-- vim.api.nvim_set_current_win(current_win)
			end

			--wincmd = "belowright 15 split",
			-- The available REPL palattes that `yarepl` can create REPL based on.   -- when a REPL process exits, should the window associated with those REPLs closed?
			-- To disable a built-in meta, set its key to `false`, e.g., `metas = { R = false }`
			opts.metas = {
				aichat = false,
				radian = false,
				ipython = { cmd = "ipython", formatter = "bracketed_pasting" },
				python = false,
				R = false,
				bash = false,
				zsh = false,
			}
			opts.close_on_exit = true
			-- whether automatically scroll to the bottom of the REPL window after sending
			-- text? This feature would be helpful if you want to ensure that your view
			-- stays updated with the latest REPL output.
			opts.scroll_to_bottom_after_sending = false
			-- Format REPL buffer names as #repl_name#n (e.g., #ipython#1) instead of using terminal defaults
			opts.format_repl_buffers_names = true
			require("yarepl.extensions.code_cell").register_text_objects({
				{
					key = "c",
					start_pattern = "```.+",
					end_pattern = "^```$",
					ft = { "rmd", "quarto", "markdown" },
					desc = "markdown code cells",
				},
				{
					key = "<Leader>c",
					start_pattern = "^# ?%%%%.*",
					end_pattern = "^# ?%%%%.*",
					ft = { "r", "python" },
					desc = "r/python code cells",
				},
			})
		end,
		keys = {
			{ "<leader>rp", "<cmd>REPLStart ipython<cr><cmd>wincmd h<cr>", desc = "Start an ipython REPL" },
			{ "<leader>rq", "<cmd>REPLClose<cr>", desc = "Close the current REPL" },
			{ "<leader>ra", "<cmd>REPLAttachBufferToREPL<cr>", desc = "Attach current buffer to a REPL" },
			{ "<leader>sv", "<cmd>REPLSendVisual<cr>", desc = "Send code to REPL", mode = { "v" } },
			{ "<leader>sl", "<cmd>REPLSendLine<cr>", desc = "Send line to REPL" },
			{ "<leader>sf", "ggvG<cmd>REPLSendVisual<cr>", desc = "Send file to REPL" },
			{ "<leader>so", "<cmd>REPLSendOperator<cr>", desc = "Send motion to REPL" },
			{ "<leader>sp", "1Gv5G<cmd>REPLSendVisual<cr>", desc = "Send cell to REPL" },
			{ "<leader>ss", "<cmd>REPLSendOperator<cr>ih", desc = "Send visual selection to REPL" },
		},
	},
}
