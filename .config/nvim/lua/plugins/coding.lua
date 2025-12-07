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
    "Piotr1215/pairup.nvim",
    cmd = { "Pairup" },
    keys = {
      { "<leader>cc", "<cmd>Pairup start<cr>",     desc = "Start Claude" },
      { "<leader>ct", "<cmd>Pairup toggle<cr>",    desc = "Toggle terminal" },
      { "<leader>cq", "<cmd>Pairup questions<cr>", desc = "Show questions" },
      { "<leader>cx", "<cmd>Pairup stop<cr>",      desc = "Stop Claude" },
    },
    config = function()
      -- Default works out of the box. Override only if needed:
      require("pairup").setup({
        provider = "claude",
        providers = {
          claude = {
            -- Full command with flags (default includes acceptEdits)
            cmd = "copilot --stream on",
          }
        }
      })
    end,
  },
  {
    "jpalardy/vim-slime",
    ft = { "python", "lua", "sh", "zsh", "bash", "ipython", "markdown" },
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
        nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>sc <Plug>SlimeCellsSendAndGoToNext
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
  {
    "nvim-mini/mini.diff",
    version = "*",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      source = {
        attach = function()
          return false
        end,
      },
      mappings = {
        -- Apply hunks inside a visual/operator region
        apply = "",

        -- Reset hunks inside a visual/operator region
        reset = "",

        -- Hunk range textobject to be used inside operator
        -- Works also in Visual mode if mapping differs from apply and reset
        textobject = "",

        -- Go to hunk range in corresponding direction
        goto_first = "",
        goto_prev = "",
        goto_next = "",
        goto_last = "",
      },
    },
    enabled = true,
  },

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
        {
          ["My New Prompt"] = {
            strategy = "inline",
            opts = {
              mapping = "<LocalLeader>ch",
              user_prompt = false,
              auto_submit = true,
            pre_hook = function(ctx)
              -- This ensures the context contains the full buffer
              ctx.context = ctx.context or {}
              ctx.context.buffer = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
              return ctx
            end,
            placement = "current_buffer", -- Optional, ensures output goes to current buffer
            },
            description = "Some cool custom prompt you can do",
            prompts = {
              {
                role = "system",
                content = "You are an experienced developer with Lua and Neovim."
              },
              {
                role = "user",
                content =
                "Can you find any lines that have comments beginning with cc: then follow the instructions in the cc comment? Here is the code:\n\n```lua\n{{context.buffer}}\n```"
              }
            },
          }
        },
        ["My Old Prompt"] = {
          strategy = "inline",
          opts = {
            mapping = "<LocalLeader>ch",
            user_prompt = false,
            auto_submit = true,
          },
          description = "Some cool custom prompt you can do",
          prompts = {
            {
              role = "system",
              content = "You are an experienced developer with Lua and Neovim."
            },
            {
              role = "user",
              content =
              "Can you find any lines that have comments beginning with cc: then follow the instructions in the cc comment.  {{context.buffer}} "
            }
          },
        }
      },
      display = {
        chat = {
          window = { layout = "float", height = 0.40, width = 0.7, title = " Code Companion " },
          -- window = { layout = "vertical", position = "left", width = 0.30, title = " Code Companion " },
          start_in_insert_mode = false,
        },
        -- diff = {
        -- provider = "mini_diff",
        -- },
      },
      strategies = {
        chat = {
          roles = {
            user = "Human",
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
                i = { "<C-CR>", "<CR><CR>" },
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
      adapters = {
        http = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              -- env = {
              -- 				api_key = "ANTHROPIC_API_KEY",
              -- 			},
              schema = {
                -- 				---@type CodeCompanion.Schema
                model = {
                  order = 1,
                  mapping = "parameters",
                  type = "enum",
                  desc =
                  "The model that will complete your prompt. See https://docs.anthropic.com/claude/docs/models-overview for additional details and options.",
                  default = "claude-3-7-sonnet-20250219",
                  choices = {
                    ["claude-3-7-sonnet-20250219"] = { opts = { can_reason = false } },
                    "claude-3-5-sonnet-20241022",
                    "claude-3-5-haiku-20241022",
                    "claude-3-opus-20240229",
                    "claude-2.1",
                  },
                },
              },
            })
          end,
        },
      },
    },
    keys = {
      { "<leader>i", ":'<,'>CodeCompanion<cr>",           desc = "Inline code companion", mode = { "v" },     silent = true },
      -- { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
      { "gt",        "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat companion", mode = { "n", "v" } },
      -- { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Toggle actions companion", mode = { "n", "v" } },
    },
  },
}
