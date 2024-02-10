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
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = { animation = require("mini.indentscope").gen_animation.none() },
    },
  },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "folke/trouble.nvim", enabled = false },
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  -- { "L3MON4D3/LuaSnip", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- options for vim.diagnostic.config()
      --   -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
      diagnostics = {
        virtual_text = { false, severity = { min = vim.diagnostic.severity.ERROR } },
        underline = false,
        signs = { false, severity = { min = vim.diagnostic.severity.ERROR } },
        update_in_insert = false,
      },
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
      },
      inlay_hints = {
        enabled = false,
      },
    },
    enabled = true,
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

  {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
      vim.g.vimtex_view_general_viewer = "sioyek"
      vim.g.vimtex_view_enabled = 1
      vim.g.vimtex_quickfix_open_on_warning = 0
      -- set line wrapping on
      vim.g.wrap =
        true, vim.cmd([[
      nmap <Up> gk
      nmap <Down> gj
      imap <Up> <C-o>gk
      imap <Down> <C-o>gj
      vmap <Up> gk
      vmap <Down> gj
      nmap <leader>vc :VimtexCompile<CR>
      nmap <leader>vv :VimtexView<CR>
      nmap <leader>vt :VimtexTocToggle<CR>
      ]])
    end,
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "arduino",
        "bash",
        "c",
        "cpp",
        "html",
        "javascript",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
