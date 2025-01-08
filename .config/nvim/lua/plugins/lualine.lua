return {

  {
    "christopher-francisco/tmux-status.nvim",
    lazy = true,
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return require("tmux-status").tmux_session()
        end,
        cond = function()
          return require("tmux-status").show()
        end,
        padding = { left = 3, right = 3 },
      })
    end,
  },

  -- opts = function(_, opts)
  --   local Util = require("lazyvim.util")
  --   local Snacks = require("snacks")
  --   local colors = {
  --     [""] = Snacks.util.color("Normal"),
  --     ["Normal"] = Snacks.util.color("Special"),
  --     ["Warning"] = Snacks.util.color("DiagnosticError"),
  --     ["InProgress"] = Snacks.util.color("DiagnosticWarn"),
  --   }
  --   table.insert(opts.sections.lualine_x, 2, {
  --     function()
  --       local icon = require("lazyvim.config").icons.kinds.Copilot
  --       local status = require("copilot.api").status.data
  --       return icon .. (status.message or "")
  --     end,
  --     cond = function()
  --       if not package.loaded["copilot"] then
  --         return
  --       end
  --       local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
  --       if not ok then
  --         return false
  --       end
  --       return ok and #clients > 0
  --     end,
  --     color = function()
  --       if not package.loaded["copilot"] then
  --         return
  --       end
  --       local status = require("copilot.api").status.data
  --       return colors[status.status] or colors[""]
  --     end,
  --   })
  -- end,
}
