return {
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = {
      filetypes = {
        markdown = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<S-Right>",
          accept_word = "<S-Down>",
          accept_line = false,
          next = "<S-Up>",
          prev = "<C-S-Up>",
          dismiss = "<C-c>",
        },
      },
      panel = {
        enabled = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<C-p>",
        },
      },
    },
  },
  -- lazy.nvim
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = "copilot.lua",
  --   opts = {},
  --   config = function(_, opts)
  --     local copilot_cmp = require("copilot_cmp")
  --     copilot_cmp.setup(opts)
  --     -- attach cmp source whenever copilot attaches
  --     -- fixes lazy-loading issues with the copilot cmp source
  --     require("lazyvim.util").lsp.on_attach(function(client)
  --       if client.name == "copilot" then
  --         copilot_cmp._on_insert_enter({})
  --       end
  --     end)
  --   end,
  -- },
  {
    "echasnovski/mini.comment",
    opts = {
      mappings = {
        comment = "gc",
        comment_visual = "<leader>/",
        textobject = "gc",
        comment_line = "<leader>/",
      },
    },
  },
  {
    "jpalardy/vim-slime",
    lazy = false,
    ft = { "python", "lua", "sh", "zsh", "bash", "ipython", "markdown" },
    config = function()
      vim.g.slime_target = "tmux"
      -- vim.g.slime_config = { socket_name = "default", target_pane = "{right}" }
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{right}" }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1

      vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>SlimeSendCurrentLine<cr>j", { desc = "Send current line" })
    end,
  },

  {
    "klafyvel/vim-slime-cells",
    requires = { { "jpalardy/vim-slime", opt = true } },
    ft = { "python", "ipython", "lua", "sh", "zsh", "bash", "markdown" },
    config = function()
      vim.g.slime_cell_delimiter = "^\\s*##"

      vim.cmd([[
        nmap <S-CR> <Plug>SlimeCellsSendAndGoToNext
        nmap <C-CR> <Plug>SlimeCellsSendAndGoToNext
        xmap <S-CR> <Plug>SlimeRegionSend
        xmap <C-CR> <Plug>SlimeRegionSend
        imap <S-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        imap <C-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        nmap <leader>cv <Plug>Slimeconfig
        nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>sc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>ss <Plug>SlimeCellsSend
        nmap <S-Down> <Plug>SlimeCellsNext
        nmap <S-Up> <Plug>SlimeCellsPrev
        ]])
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  {
    "echasnovski/mini.diff",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.diff",
      "saghen/blink.nvim",
    },
    config = true,
    opts = {
      display = {
        chat = {
          window = { layout = "float" },
        },
        diff = {
          provider = "mini_diff",
        },
      },
      strategies = {
        chat = {
          roles = {
            user = "Human",
          },
          adapter = "anthropic",
          keymaps = {
            hide = {
              modes = {
                n = { "q", "<esc>" },
              },
              callback = function(chat)
                chat.ui:hide()
              end,
              description = "Hide the chat buffer",
            },
          },
        },
        inline = {
          adapter = "anthropic",
          keymaps = {
            accept_change = {
              modes = {
                n = "a",
              },
              index = 1,
              callback = "keymaps.accept_change",
              description = "Accept change",
            },
            reject_change = {
              modes = {
                n = "r",
              },
              index = 2,
              callback = "keymaps.reject_change",
              description = "Reject change",
            },
          },
        },
      },
    },
    keys = {
      { "<leader>i", ":'<,'>CodeCompanion<cr>", desc = "Inline code companion", mode = { "v" }, silent = true },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
      { "<c-p>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v", "i" } },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Toggle actions companion", mode = { "n", "v" } },
    },
  },
  
}
