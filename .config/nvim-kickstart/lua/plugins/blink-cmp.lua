return {
	"saghen/blink.cmp",
	enabled = true,
	version = "*",
	opts = function(_, opts)
		opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
			default = { "lsp", "path", "buffer" }, -- "codecompanion" },
			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					score_offset = 90, -- the higher the number, the higher the priority
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 25,
					fallbacks = { "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				buffer = {
					name = "Buffer",
					enabled = true,
					max_items = 3,
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 2,
					score_offset = 15, -- the higher the number, the higher the priority
				},
			},
			cmdline = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		})
		opts.appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "normal",
		}

		opts.signature = {
			enabled = false,
		}

		opts.completion = {

			menu = {
				border = "rounded",
				winhighlight = "Normal:None,FloatBorder:None",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
				},
			},
			ghost_text = {
				enabled = false,
			},
			list = { selection = { preselect = false, auto_insert = true } },
		}

		opts.keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<S-k>"] = { "scroll_documentation_up", "fallback" },
			["<S-j>"] = { "scroll_documentation_down", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-x>"] = { "cancel", "fallback" },
			cmdline = {
				preset = "default",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
		}

		return opts
	end,
}
