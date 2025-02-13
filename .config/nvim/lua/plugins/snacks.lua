return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		dashboard = { enabled = true },
		indent = { enabled = true },
		bufdelete = { enabled = true },
		notifier = { enabled = true },
		scroll = { enabled = true },
		quickfile = { enabled = true },
		image = { enabled = true },
		statuscolumn = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				explorer = {
					tree = false,
					follow_file = false,
					layout = { preset = "default", preview = true },
					exclude = { "*/*" },
					include = { "*", ".*" },
					auto_close = true,
					actions = {
						up_and_close = function(picker, item)
							local Tree = require("snacks.explorer.tree")
							picker:set_cwd(vim.fs.dirname(picker:cwd()))
							Tree:close_all(picker:cwd())
							picker:find()
						end,
						enter_and_clear = function(picker, item)
							picker:set_cwd(picker:dir())
							picker.input:set("", "")
							picker:find()
						end,
						smart_enter = function(picker, item, action)
							if not item then
								return
							elseif item.dir then
								picker:set_cwd(picker:dir())
								picker.input:set("", "")
								picker:find()
							else
								Snacks.picker.actions.jump(picker, item, action)
							end
						end,
					},
					focus = "input",
					win = {
						input = {
							keys = {
								["<CR>"] = { "smart_enter", mode = { "n", "i" } },
								["<S-CR>"] = { "explorer_open", mode = { "n", "i" } },
								["<Left>"] = { "up_and_close", mode = { "n", "i" } },
								["<Right>"] = { "enter_and_clear", mode = { "n", "i" } },
								["<C-h>"] = { "toggle_hidden", mode = { "n", "i" } },
							},
						},
					},
				},
			},
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
					},
				},
			},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fn",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		-- {
		-- 	"<leader>fe",
		-- 	function()
		-- 		Snacks.explorer()
		-- 	end,
		-- 	desc = "File Explorer",
		-- },
		-- find
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fG",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			"<leader>fy",
			function()
				Snacks.picker.registers()
			end,
			desc = "Clipboard History",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>f?",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>fu",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>fS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
	},
}
