return {
  {
    "sainnhe/everforest",
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    init = function()
      vim.g.lsp_handlers_enabled = false
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      -- other stuff
      background_colour = "#000000",
    },
  },
  { "echasnovski/mini.pairs", enabled = false },
  { "folke/trouble.nvim", enabled = false },
  -- { "L3MON4D3/LuaSnip", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- options for vim.diagnostic.config()
      --   -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
      diagnostics = {
        virtual_text = { true, severity = { min = vim.diagnostic.severity.ERROR } },
        underline = false,
        signs = { true, severity = { min = vim.diagnostic.severity.ERROR } },
        update_in_insert = false,
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ 
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ 
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ 
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ 
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ 
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ 
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      -- customize the opts header
      -- -- Set header
      opts.config.header = vim.split(logo, "\n")

      return opts
    end,
  },
}
