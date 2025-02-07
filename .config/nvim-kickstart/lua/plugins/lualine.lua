return {
	{
		"vimpostor/vim-tpipeline",
		dependencies = "nvim-lualine/lualine.nvim",
		enabled = true,
		event = "VeryLazy",
		init = function()
			vim.g.tpipeline_restore = 1
		end,
	},
	{

		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			-- require("lualine").setup(opts)
			-- local lualine_require = require("lualine_require")
			-- lualine_require.require = require

			local icons = require("config.icons")

			vim.o.laststatus = vim.g.lualine_laststatus

			local opts = {
				options = {
					theme = "auto",
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },

					lualine_c = {
						-- LazyVim.lualine.root_dir(),
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename" },
					},
					lualine_x = {
						Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree", "lazy", "fzf" },
			}

			-- do not add trouble symbols if aerial is enabled
			-- And allow it to be overriden for some buffer types (see autocmds)
			if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
				local trouble = require("trouble")
				local symbols = trouble.statusline({
					mode = "symbols",
					groups = {},
					title = false,
					filter = { range = true },
					format = "{kind_icon}{symbol.name:Normal}",
					hl_group = "lualine_c_normal",
				})
				table.insert(opts.sections.lualine_c, {
					symbols and symbols.get,
					cond = function()
						return vim.b.trouble_lualine ~= false and symbols.has()
					end,
				})
			end

			return opts
		end,
		-- 	if os.getenv("TMUX") then
		-- 		vim.defer_fn(function()
		-- 			vim.o.laststatus = 0
		-- 		end, 0)
		-- 	end
		-- end,
	},
}

--   {
--     "vimpostor/vim-tpipeline",
--     -- "christopher-francisco/tmux-status.nvim",
--     -- lazy = true,
--     -- opts = {},
--   },
--   {
--     "nvim-lualine/lualine.nvim",
--     enabled = true,
--     -- opts = function(_, opts)
--     --   table.insert(opts.sections.lualine_x, {
--     --     function()
--     --       return require("tmux-status").tmux_session()
--     --     end,
--     --     cond = function()
--     --       return require("tmux-status").show()
--     --     end,
--     --     padding = { left = 3, right = 3 },
--     --   })
--     -- end,
--   },
--
--   -- opts = function(_, opts)
--   --   local Util = require("lazyvim.util")
--   --   local Snacks = require("snacks")
--   --   local colors = {
--   --     [""] = Snacks.util.color("Normal"),
--   --     ["Normal"] = Snacks.util.color("Special"),
--   --     ["Warning"] = Snacks.util.color("DiagnosticError"),
--   --     ["InProgress"] = Snacks.util.color("DiagnosticWarn"),
--   --   }
--   --   table.insert(opts.sections.lualine_x, 2, {
--   --     function()
--   --       local icon = require("lazyvim.config").icons.kinds.Copilot
--   --       local status = require("copilot.api").status.data
--   --       return icon .. (status.message or "")
--   --     end,
--   --     cond = function()
--   --       if not package.loaded["copilot"] then
--   --         return
--   --       end
--   --       local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
--   --       if not ok then
--   --         return false
--   --       end
--   --       return ok and #clients > 0
--   --     end,
--   --     color = function()
--   --       if not package.loaded["copilot"] then
--   --         return
--   --       end
--   --       local status = require("copilot.api").status.data
--   --       return colors[status.status] or colors[""]
--   --     end,
--   --   })
--   -- end,
-- }
