return {
	-- { "mrjones2014/smart-splits.nvim", lazy = false },
	{
		-- 	dir = "~/workspace/terminal-image.nvim",
		-- 	name = "terminal-image.nvim",
		-- 	config = true,
		-- },{
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
			format_on_save = true,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "blue" },
			},
		},
	},
	{
		"folke/flash.nvim",
		---@type Flash.Config
		opts = {},
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
