-- ------------------------------------------------------------------------------------------------
--                            COPILOT - LOADED ON INSERTENTER
-- ------------------------------------------------------------------------------------------------

vim.pack.add({{
	src = "https://github.com/zbirenbaum/copilot.lua",
  version = "v2.0.0"}
})

require("copilot").setup({
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
	},
})

vim.keymap.set("n", "<leader>tc", function() require("copilot.suggestion").toggle_auto_trigger() end, { desc = "Toggle Copilot auto trigger" })


-- vim.pack.add({
--   "https://github.com/linw1995/nvim-mcp",
-- })
--
-- require("nvim-mcp").setup({
-- })

-- --  Start the Neovim server for external communication in home directory, allowing other applications to connect to Neovim via the specified socket.
-- vim.fn.mkdir(vim.fn.expand("~/tmp"), "p")  -- Create the directory if it doesn't exist
vim.fn.serverstop(vim.fn.expand("~/tmp/nvim.sock"))  -- Stop any existing server on the same socket
vim.fn.serverstart(vim.fn.expand("~/tmp/nvim.sock"))  -- Start the server on the specified socket

-- ------------------------------------------------------------------------------------------------
--                            SLIME - LOADED FOR PYTHON FILES
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	"https://github.com/jpalardy/vim-slime",
	"https://github.com/klafyvel/vim-slime-cells",
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "python", "ipython", "R" },
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
