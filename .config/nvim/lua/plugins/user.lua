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
    enabled = true,
    opts = {
      -- other stuff
      background_colour = "#000000",
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    config = function()
      vim.g.autoformat = false
    end,
  },
  { "echasnovski/mini.pairs", enabled = false },
  {
    "akinsho/bufferline.nvim",
    -- opts will be merged with the parent spec
    opts = { options = { indicator = { style = "none" }, separator_style = "thin", show_tab_indicators = false } },
  },
  {
    "numtostr/FTerm.nvim",
    event = "BufWinEnter",
    config = function()
      require("FTerm").setup({
        dimensions = { height = 0.8, width = 0.8 },
        border = "rounded",
      })
      vim.api.nvim_set_keymap(
        "n",
        "<leader>tt",
        "<cmd>lua require('FTerm').toggle()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },

  {
  "roobert/search-replace.nvim",
  config = function()
    require("search-replace").setup({
      -- optionally override defaults
      default_replace_single_buffer_options = "gcI",
      default_replace_multi_buffer_options = "egcI",
    })
  end,
},

  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = { animation = require("mini.indentscope").gen_animation.none() },
    },
  },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "kdheepak/lazygit.nvim",
    event = "BufRead",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gg",
        "<cmd>LazyGitCurrentFile<CR>",
        { desc = "Lazygit (current file)", noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gG",
        "<cmd>LazyGit<CR>",
        { desc = "Lazygit (cwd)", noremap = true, silent = true }
      )
    end,
    --   -- your custom options here
    --   -- vim.keymap.set("n", "<leader>gg", function()
    --   --   print("A lua func")
    --   -- end, { noremap = true, expr = true })
    --   vim.keymap.set("n", "<leader>gg", function()
    --     local git_dir = nil
    --     local is_inside_git
    --     vim.fn.system("git rev-parse --is-inside-work-tree")
    --     is_inside_git = vim.v.shell_error == 0
    --     if is_inside_git then
    --       git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
    --       git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
    --     end
    --     require("lazygit").lazygit()
    --   end, { desc = "Lazygit", noremap = true, expr = true })
    -- end,
    -- opts = {
    --   keys = {
    --     "<leader>gg",
    --     function()
    --       local git_dir = nil
    --       local is_inside_git
    --       vim.fn.system("git rev-parse --is-inside-work-tree")
    --       is_inside_git = vim.v.shell_error == 0
    --       if is_inside_git then
    --         git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
    --         git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
    --       end
    --       require("lazygit").lazygit(git_dir)
    --     end,
    --     desc = "Lazy git in current buffer directory",
    --   },
    -- },
  },
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
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk_engines = { 
            pdflatex = '-pdf',
            lualatex = '-lualatex',
            xelatex = '-xelatex',
            context = '-pdf',
            platex = '-pdfdvi',
            uplatex = '-pdfdvi',
            ['_'] = '-xelatex'
      }
      --     '_', '-xelatex' -- '_'                = '-xelatex'
      -- }
      vim.g.vimtex_compiler_latexmk = { 
         executable = 'latexmk',
         options = { 
           '-xelatex',
           '-file-line-error',
           '-synctex=1',
           '-interaction=nonstopmode',
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
}
