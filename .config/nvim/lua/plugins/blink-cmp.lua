return {
	"saghen/blink.cmp",
	enabled = true,
	event = "InsertEnter",
	version = "*",
	opts = function(_, opts)
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
		}

		opts.cmdline = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},

			-- cmdline = {
			--   keymap = {
			--     -- recommended, as the default keymap will only show and select the next item
			--     ['<Tab>'] = { 'show', 'accept' },
			--   },
			completion = {
				menu = {
					auto_show = true,
				},
				ghost_text = { enabled = true },
				list = {
					selection = {
						-- When `true`, will automatically select the first item in the completion list
						preselect = false,
						-- When `true`, inserts the completion item automatically when selecting it
						auto_insert = true,
					},
				},
			},

			sources = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		}

		return opts
	end,
}
