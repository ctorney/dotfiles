return {
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
  { "mrjones2014/smart-splits.nvim", lazy = false },

  -- {
  --   "aaronik/treewalker.nvim",
  --   opts = {
  --     highlight = true, -- Whether to briefly highlight the node after jumping to it
  --     highlight_duration = 250, -- How long should above highlight last (in ms)
  --   },
  --   keys = {
  --     {
  --       "<Down>",
  --       "<cmd>Treewalker Down<CR>",
  --       mode = { "n", "v" },
  --       desc = "Treewalker Down",
  --     },
  --     {
  --       "<Up>",
  --       "<cmd>Treewalker Up<CR>",
  --       mode = { "n", "v" },
  --       desc = "Treewalker Up",
  --     },
  --     {
  --       "<Left>",
  --       "<cmd>Treewalker Left<CR>",
  --       mode = { "n", "v" },
  --       desc = "Treewalker Left",
  --     },
  --     {
  --       "<Right>",
  --       "<cmd>Treewalker Right<CR>",
  --       mode = { "n", "v" },
  --       desc = "Treewalker Right",
  --     },
  --   },
  -- },
  -- { "folke/todo-comments.nvim", version = "*" },
  {
    "pimalaya/himalaya-vim",
    config = function()
      vim.g.himalaya_folder_picker = "telescope"
      vim.g.himalaya_folder_picker_telescope_preview = 1
    end,
  },

  {
    "okuuva/auto-save.nvim",
    enabled = false,
    version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },
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
  },
  { "echasnovski/mini.pairs", enabled = false },
  {
    "akinsho/bufferline.nvim",
    opts = { options = { indicator = { style = "none" }, separator_style = "thin", show_tab_indicators = false } },
  },
  {
    "numtostr/FTerm.nvim",
    event = "BufWinEnter",
    opts = {
      dimensions = { height = 0.8, width = 0.8 },
      border = "rounded",
    },
    keys = {
      {
        "<S-/>",
        function()
          require("FTerm").toggle()
        end,
        mode = { "n", "x", "o", "t", "i" },
        desc = "Toggle FTerm",
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = { animation = require("mini.indentscope").gen_animation.none() },
    },
  },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Obsidian",
        },
      },
    },
  },
  { "folke/trouble.nvim", enabled = true },
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  -- { "L3MON4D3/LuaSnip", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },
  { "folke/flash.nvim", enabled = true },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
      },
    },
  },
  {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
      vim.g.vimtex_view_general_viewer = "open"
      vim.g.vimtex_view_enabled = 1
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk_engines = {
        pdflatex = "-pdf",
        lualatex = "-lualatex",
        xelatex = "-xelatex",
        context = "-pdf",
        platex = "-pdfdvi",
        uplatex = "-pdfdvi",
        ["_"] = "-xelatex",
      }
      --     '_', '-xelatex' -- '_'                = '-xelatex'
      -- }
      vim.g.vimtex_compiler_latexmk = {
        executable = "latexmk",
        options = {
          "-xelatex",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
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
        "yaml",
      },
    },
  },
  {
    "christopher-francisco/tmux-status.nvim",
    lazy = true,
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      win = {
        no_overlap = false,
        height = { min = 4, max = 50 },
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
      wo = {
        winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
  },
  {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      extensions = {
        lazy_nvim = true,
      },
    },
  },
}
