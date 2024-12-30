return {
  {
    "zbirenbaum/copilot.lua",
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
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- table.insert(opts.sources, 1, {
      --   name = "copilot",
      --   group_index = 1,
      --   priority = 100,
      -- })

      opts.completion = {
        autocomplete = false,
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if not cmp.visible() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_prev_item()
        --   elseif luasnip.jumpable(-1) then
        --     luasnip.jump(-1)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
        ["<Right>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()

            -- cmp.confirm({ select = true })
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
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
    ft = { "python", "lua", "sh", "zsh", "bash", "ipython", "markdown" },
    config = function()
      vim.g.slime_target = "wezterm"
      vim.g.slime_default_config = { pane_direction = "right" }

      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
      vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>SlimeSendCurrentLine<cr>j", { desc = "Send current line" })

      vim.api.nvim_exec(
        [[
        function! SlimeOverrideSend(config, text)
          let pane_id = slime#common#system("wezterm cli get-pane-direction %s", ["right"])
          let pane_id = trim(pane_id)
          if pane_id == ""
            echom "No wezterm target pane found"
            return
          endif
          let [bracketed_paste, text_to_paste, has_crlf] = slime#common#bracketed_paste(a:text)

          if bracketed_paste
            call slime#common#system("wezterm cli send-text --pane-id=%s", [pane_id], text_to_paste)
          else
            call slime#common#system("wezterm cli send-text --no-paste --pane-id=%s", [pane_id], text_to_paste)
          endif
          if has_crlf
            call slime#common#system("wezterm cli send-text --no-paste --pane-id=%s", [pane_id], "\n")
          end
        endfunction
      ]],
        false
      )
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
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "copilot", -- Recommend using Claude
      auto_suggestions_provider = "copilot",
      auto_apply_diff_after_generation = true,
      -- add any opts here
      windows = {
        ask = { floating = false, border = "rounded" },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- {
  --   "robitx/gp.nvim",
  --   config = function()
  --     require("gp").setup({
  --       chat_user_prefix = "🗨",
  --       chat_assistant_prefix = "🤖",
  --       chat_confirm_delete = false,
  --       style_highlight = "None",
  --       style_popup_border = "rounded",
  --       style_popup_keep_buf = true,
  --       style_popup_left_margin = 1,
  --       style_popup_title = " ChatGPT 4 ",
  --       -- chat_prompt_buf_type = true,
  --       style_popup_winhighlight = "Normal:Normal,FloatBorder:Normal,FloatTitle:Normal,WinBar:Normal",
  --       toggle_target = "popup",
  --       agents = {
  --         -- Disable ChatGPT 3.5
  --         {
  --           name = "ChatGPT3-5",
  --           disable = true,
  --           chat = false, -- just name would suffice
  --           command = false, -- just name would suffice
  --         },
  --         {
  --           name = "ChatGPT4",
  --           chat = true,
  --           command = true,
  --           -- string with model name or table with model name and parameters
  --           model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
  --           -- system prompt (use this to specify the persona/role of the AI)
  --           system_prompt = "You are a general AI assistant.\n\n"
  --             .. "The user provided the additional info about how they would like you to respond:\n\n"
  --             .. "- If you're unsure don't guess and say you don't know instead.\n"
  --             .. "- Ask question if you need clarification to provide better answer.\n"
  --             .. "- Think deeply and carefully from first principles step by step.\n"
  --             .. "- Make your response clear and brief.\n"
  --             .. "- Do not give advice unless it has been requested.\n"
  --             .. "- If asked for code only provide the code and don't provide any explanation.\n",
  --         },
  --       },
  --       -- chat_model = { model = "gpt-4", temperature = 1.1, top_p = 1 },
  --       -- command_model = { model = "gpt-4", temperature = 1.1, top_p = 1 },
  --       -- chat_custom_instructions = "When providing code just give the code and don't explain it.\n"
  --       -- .. "Only provide the raw code without markdown markers.\n",
  --       -- hooks = {
  --       --   Explain = function(gp, params)
  --       --     local template = "I have the following code from {{filename}}:\n\n"
  --       --     .. "```{{filetype}}\n{{selection}}\n```\n\n"
  --       --     .. "Please respond by explaining the code above."
  --       --     gp.Prompt(params, gp.Target.popup, nil, gp.config.command_model,
  --       --       template, gp.config.chat_system_prompt)
  --       --   end,
  --       --   Email = function(gp, params)
  --       --     local template = "The text below is from an email chain with the most recent message at the top.\n"
  --       --           .. "The text of all previous messages start with the > character. \n"
  --       --           .. "Write an email response to the chain as though you were Colin Torney, "
  --       --           .. "a Professor of Applied Mathematics. \n\n"
  --       --           .. "If there is any text at the start that does not begin with > use this text "
  --       --           .. "as further instruction for the email response. \n"
  --       --           .. "Return only the text of the email. \n"
  --       --           .. "Try not to repeat text from the email chain in your response. \n"
  --       --           .. "Start the email with Hi and the first name of the recipient and end with Best wishes, Colin. \n"
  --       --           .. "Compose the response in a terse and very concise style and sign off with first name only. \n\n"
  --       --           .. "```{{selection}}\n```\n\n"
  --       --     params.range = 2
  --       --     params.line1 = 1
  --       --     params.line2 = 100
  --       --     local chat_model = { model = "gpt-4", temperature = 0.7, top_p = 1 }
  --       --     gp.Prompt(params, gp.Target.prepend, nil, gp.config.command_model,
  --       --       template, gp.config.chat_system_prompt)
  --       --   end,
  --       -- }
  --     })
  --     vim.keymap.set(
  --       { "n" },
  --       "gt",
  --       "<cmd>GpChatToggle<cr>",
  --       { noremap = true, silent = true, nowait = true, desc = "GPT4 Toggle Chat" }
  --     )
  --
  --     -- or setup with your own config (see Install > Configuration in Readme)
  --     -- require("gp").setup(config)
  --
  --     -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
  --   end,
  -- },
}
