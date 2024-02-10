return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufRead",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<S-Right>",
            accept_word = "<M-Right>",
            accept_line = false,
            next = "<S-Down>",
            prev = "<S-Up>",
            dismiss = "<C-c>",
          },
        },
        panel = {
          enabled = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<C-p>",
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      require("lazyvim.util").lsp.on_attach(function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter({})
        end
      end)
    end,
  },
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
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        priority = 100,
      })
      opts.completion = {
        autocomplete = false,
      }
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "jpalardy/vim-slime",
    lazy = false,
    ft = { "python", "lua", "sh", "zsh", "bash", "ipython" },
    config = function()
      -- vim.g.slime_target = "tmux"
      -- vim.g.slime_config = {socket_name="default", target_pane="{right}"}
      vim.g.slime_target = "zellij"
      vim.g.slime_config = { session_id = "current", relative_pane = "right" } --, relative_move_back="left"}
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
      vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>SlimeSendCurrentLine<cr>", { desc = "Send current line" })
    end,
  },

  {
    "klafyvel/vim-slime-cells",
    requires = { { "jpalardy/vim-slime", opt = true } },
    ft = { "python", "ipython" },
    config = function()
      -- vim.g.slime_target = "tmux"
      -- vim.g.slime_default_config = {socket_name="default", target_pane="{right}"}
      vim.g.slime_target = "zellij"
      vim.g.slime_cell_delimiter = "^\\s*##"
      vim.g.slime_default_config = { session_id = "current", relative_pane = "right", relative_move_back = "left" }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
      vim.cmd([[
        nmap <S-CR> <Plug>SlimeCellsSendAndGoToNext
        nmap <C-CR> <Plug>SlimeCellsSendAndGoToNext
        xmap <S-CR> <Plug>SlimeRegionSend
        xmap <C-CR> <Plug>SlimeRegionSend
        imap <S-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        imap <C-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        nmap <leader>cv <Plug>Slimeconfig
        nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>cj <Plug>SlimeCellsNext
        nmap <leader>ck <Plug>SlimeCellsPrev
        ]])
    end,
  },
}
