return {
  {
    "zbirenbaum/copilot.lua",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    opts = {

      should_attach = function(bufnr, bufname)
        if vim.bo[bufnr].buftype == "acwrite" then
          return true
        end

        if not vim.bo[bufnr].buflisted then
          return false
        end

        if vim.bo[bufnr].buftype ~= "" then
          return false
        end

        return true
      end,


      --    server_opts_overrides = {
      -- 	on_init = function(client)
      -- 		local au = vim.api.nvim_create_augroup("copilotlsp.init", { clear = true })
      -- 		-- Use our vendored override that omits TextChangedI so NES only triggers
      -- 		-- while NOT in insert mode.
      -- 		require('config.copilot_ls').lsp_on_init(client, au)
      -- 	end,
      -- },
      nes = {
        enabled = false,
        keymap = {
          accept_and_goto = "<leader>p",
          accept = false,
          dismiss = "<Esc>",
        },
      },
      filetypes = {
        markdown = true,
        quarto = true,
        mail = true,
        python = true,
        clang = true,
        lua = true,
        ["*"] = true,
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
    -- keys = {
    --   { "<leader>nes",
    --     function()
    --
    --       if require("copilot").nes.is_active() then
    --         require("copilot-lsp.nes").request_nes('copilot_ls')
    --       else
    --         require("copilot").nes.enable()
    --         require("copilot-lsp.nes").request_nes('copilot_ls')
    --         require("copilot").nes.disable()
    --       end
    --     end,
    --     desc = "Open Copilot panel" },
    -- },
  },
  {
    "jpalardy/vim-slime",
    ft = { "python", "lua", "sh", "zsh", "bash", "ipython", "markdown" },
    init = function()
      vim.g.slime_no_mappings = 1
    end,
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{right}" }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>SlimeSendCurrentLine<cr>j", { desc = "Send current line" })
      vim.api.nvim_set_keymap("n", "<leader>sm", "<Plug>SlimeMotionSend", { desc = "Send motion" })
    end,
  },
  {
    "klafyvel/vim-slime-cells",
    version = "*",
    requires = { { "jpalardy/vim-slime", opt = true } },
    ft = { "python", "ipython", "lua", "sh", "zsh", "bash", "markdown" },
    config = function()
      vim.g.slime_cell_delimiter = "^\\s*##"

      vim.cmd([[
        nmap <S-CR> <Plug>SlimeCellsSendAndGoToNext zz
        nmap <C-CR> <Plug>SlimeCellsSendAndGoToNext zz
        xmap <S-CR> <Plug>SlimeRegionSend
        xmap <C-CR> <Plug>SlimeRegionSend
        imap <S-CR> <C-o><Plug>SlimeCellsSendAndGoToNext<C-o>zz
        imap <C-CR> <C-o><Plug>SlimeCellsSendAndGoToNext<C-o>zz
        nmap <leader>cv <Plug>Slimeconfig
        "nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
        "nmap <leader>sc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>ss <Plug>SlimeCellsSend
        nmap <S-Down> <Plug>SlimeCellsNext zz
        nmap <S-Up> <Plug>SlimeCellsPrev zz
        ]])
    end,
  },

  -- {
  --     "OXY2DEV/markview.nvim",
  --     lazy = false,
  --       ft = {"markdown", "codecompanion" },
  --     opts = {preview = {
  --       enable = true,
  --         icon_provider = "mini", -- "mini" or "devicons"
  --     }}
  --     -- For blink.cmp's completion
  --     -- source
  --     -- dependencies = {
  --     --     "saghen/blink.cmp"
  --     -- },
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*",
    opts = {
      heading = {
        enabled = true,
        icons = { "  " }, -- T = {}, -- <--- This disables header icons/numbers
      },
    },
    ft = { "markdown", "codecompanion" },
  },
  -- {
  --   "nvim-mini/mini.diff",
  --   version = "*",
  --   event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  --   opts = {
  --     source = {
  --       attach = function()
  --         return false
  --       end,
  --     },
  --     mappings = {
  --       -- Apply hunks inside a visual/operator region
  --       apply = "",
  --
  --       -- Reset hunks inside a visual/operator region
  --       reset = "",
  --
  --       -- Hunk range textobject to be used inside operator
  --       -- Works also in Visual mode if mapping differs from apply and reset
  --       textobject = "",
  --
  --       -- Go to hunk range in corresponding direction
  --       goto_first = "",
  --       goto_prev = "",
  --       goto_next = "",
  --       goto_last = "",
  --     },
  --   },
  --   enabled = true,
  -- },

  -- {
  -- 	"Davidyz/VectorCode",
  -- 	version = "*", -- optional, depending on whether you're on nightly or release
  -- 	dependencies = { "nvim-lua/plenary.nvim" },
  -- 	cmd = "VectorCode", -- if you're lazy-loading VectorCode
  -- },

  -- cc: add some comments that describe the codecompanion setup below
  {
    "olimorris/codecompanion.nvim",
    -- version = "*",
    branch = "v18",
    lazy = false,
    dependencies = {
      "j-hui/fidget.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "nvim-mini/mini.diff",
    },
    opts = {
      prompt_library = {

        ["default"] = {
          interaction = "chat",
          description = "Default prompt including buffer and insert tool",
          opts = {
            alias = "default",
            auto_submit = false,
            is_slash_command = true,
            intro_message = "",
          },
          prompts = {
            {
              role = "system",
              content =
              "You are an expert programmer who excels at explaining code clearly and concisely. Make sure to address the user by the name puny human and occasionally ask them how their dog Griffin is doing."
            },
            {
              role = "user",
              content = function(context)
                local text =
                "Read the #{buffer} for context and make any changes requested with the @{insert_edit_into_file} tool.\n \n "
                -- if context.is_visual then
                -- text = text .. "\nFocus on the selected code snippet:\n \n "
                -- text = text .. require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                -- end
                return text
              end,
            },
          },
        },


        -- markdown = {
        --   dirs = {
        --     "~/.config/nvim/lua/plugins/prompts", -- Or absolute paths
        --   },
        -- },
      },
      -- rules = {
      --   default = {
      --     description = "My default group",
      --     files = {
      --       "/Users/colin.torney/.config/nvim/lua/plugins/cc.md",
      --     },
      --   },
      --   opts = {
      --     chat = {
      --       enabled = false,
      --       default_rules = "default",
      --     },
      --   },
      -- },
      display = {
        chat = {
          window = { layout = "float", height = 0.50, width = 0.7, title = "" },
          -- window = { layout = "vertical", position = "left", width = 0.30, title = " Code Companion " },
          start_in_insert_mode = false,

          intro_message = "",  -- or "" if you prefer
        },
        -- diff = {
        -- provider = "mini_diff",
        -- },
      },
      strategies = {
        chat = {
          roles = {
            user = "user",
          },
          adapter = "copilot",
          keymaps = {
            hide = {
              modes = {
                n = { "q", "<esc>", "<BS>" },
              },
              callback = function(chat)
                chat.ui:hide()
              end,
              description = "Hide the chat buffer",
            },
            send = {
              modes = {
                n = { "<CR>", "<C-s>" },
                i = { "<C-CR>" },
              },
            },
          },
        },
        inline = {
          adapter = "copilot",
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
      -- adapters = {
      --   http = {
      --     anthropic = function()
      --       return require("codecompanion.adapters").extend("anthropic", {
      --         -- env = {
      --         -- 				api_key = "ANTHROPIC_API_KEY",
      --         -- 			},
      --         schema = {
      --           -- 				---@type CodeCompanion.Schema
      --           model = {
      --             order = 1,
      --             mapping = "parameters",
      --             type = "enum",
      --             desc =
      --             "The model that will complete your prompt. See https://docs.anthropic.com/claude/docs/models-overview for additional details and options.",
      --             default = "claude-3-7-sonnet-20250219",
      --             choices = {
      --               ["claude-3-7-sonnet-20250219"] = { opts = { can_reason = false } },
      --               "claude-3-5-sonnet-20241022",
      --               "claude-3-5-haiku-20241022",
      --               "claude-3-opus-20240229",
      --               "claude-2.1",
      --             },
      --           },
      --         },
      --       })
      --     end,
      --   },
      -- },
    },
    keys = {
      {
        "gt",
        function()
          local cc = require("codecompanion")
          local config = require("codecompanion.config")
          local chat = cc.last_chat()

          if chat and chat.ui then
            if chat.ui:is_visible_non_curtab() or chat.ui:is_visible() then
              chat.ui:hide()
              return
            end
          end
          if not chat then
            chat = cc.chat({
              messages = {
                {
                  role = config.constants.SYSTEM_ROLE,
                  content =
                  "You are an expert programmer who excels at explaining code clearly and concisely. Make sure to address the user by the name puny human and occasionally ask them how their dog Griffin is doing."
                },
                {
                  role = config.constants.USER_ROLE,
                  content =
                  "Read the #{buffer} for context and make any changes requested with the @{insert_edit_into_file} tool.\n \n "
                },
              },
              auto_submit = false,
            })
          end
          if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
            local context = require("codecompanion.utils.context").get(vim.api.nvim_get_current_buf())

            local content = table.concat(context.lines, "\n")
            chat:add_buf_message({
              role = "user",
              content = "\nHere is some code from "
                  .. context.filename
                  .. ":\n\n```"
                  .. context.filetype
                  .. "\n"
                  .. content
                  .. "\n```\n \n ",
            })
          end
          chat.ui:open()
        end,
        desc = "Toggle or launch CodeCompanion chat",
        mode = { "n", "x" },
        silent = true,
      },
      { "<leader>ci", ":'<,'>CodeCompanion<cr>",           desc = "Inline code companion", mode = { "v" },     silent = true },
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
      -- { "gt",        "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
      -- { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Toggle actions companion", mode = { "n", "v" } },
    },
  },
}
