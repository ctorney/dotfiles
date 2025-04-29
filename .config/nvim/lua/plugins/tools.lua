return {
	-- {
	-- 	dir = "~/workspace/arduino-tools.nvim/",
	-- 	name = "arduino-tools.nvim",
	-- 	ft = { "arduino" },
	-- 	opts = {
	-- 		cli_config = "~/Library/Arduino15/",
	-- 	},
	-- },
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "Notes",
					path = "~/Obsidian/Notes/",
				},
			},
			completion = {
				-- Enables completion using nvim_cmp
				nvim_cmp = false,
				-- Enables completion using blink.cmp
				blink = true,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			},
			picker = {
				-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
				name = "snacks.pick",
				-- Optional, configure key mappings for the picker. These are the defaults.
				-- Not all pickers support all mappings.
				note_mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
				tag_mappings = {
					-- Add tag(s) to current note.
					tag_note = "<C-x>",
					-- Insert a tag at the current location.
					insert_tag = "<C-l>",
				},
			},
		},
	},
	{
		"ctorney/terminal-image.nvim",
		opts = {},
	},
	{
		"numtostr/FTerm.nvim",
		opts = {
			dimensions = { height = 0.8, width = 0.8 },
			border = "rounded",
		},
		keys = {
			{
				"<c-/>",
				function()
					require("FTerm").toggle()
				end,
				mode = { "n", "x", "o", "t", "i" },
				desc = "Toggle FTerm",
			},
		},
	},
	-- {
	-- 	"gbprod/yanky.nvim",
	-- 	opts = {},
	-- },
	{
		"gbprod/substitute.nvim",
		config = true,
		-- opts = {
		-- 	on_substitute = function()
		-- 		require("yanky.integration").substitute()
		-- 	end,
		-- },
		keys = {
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
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>c",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = false,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "blue" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
		},
	},
	{
		"folke/flash.nvim",
		---@type Flash.Config
		opts = { jump = { autojump = true } },
		keys = {
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
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	-- Better text-objects
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
					h = function(opts)
						local cell_marker = "# %%"
						local start_line = vim.fn.search("^" .. cell_marker, "bcnW")

						if start_line == 0 then
							start_line = 1
						else
							if opts == "i" then
								start_line = start_line + 1
							end
						end

						local end_line = vim.fn.search("^" .. cell_marker, "nW") - 1
						if end_line == -1 then
							end_line = vim.fn.line("$")
						end

						if opts == "i" then
							-- Find first non-blank line after start
							local first_nonblank = vim.fn.nextnonblank(start_line)
							if first_nonblank > 0 and first_nonblank <= end_line then
								start_line = first_nonblank
							end

							-- Find last non-blank line before end
							local last_nonblank = vim.fn.prevnonblank(end_line)
							if last_nonblank >= start_line then
								end_line = last_nonblank
							end
						end

						local last_col = math.max(vim.fn.getline(end_line):len(), 1)

						local from = { line = start_line, col = 1 }
						local to = { line = end_line, col = last_col }

						return { from = from, to = to }
					end,
				},
			}
		end,
	},
}
