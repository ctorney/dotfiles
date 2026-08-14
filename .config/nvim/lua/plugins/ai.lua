vim.pack.add({{
	src = "https://github.com/zbirenbaum/copilot.lua",
  version = "v2.0.0"}
})

require("copilot").setup({
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
	},
})

vim.keymap.set("n", "<leader>tc", function() require("copilot.suggestion").toggle_auto_trigger() end, { desc = "Toggle Copilot auto trigger" })

-- Add packages
vim.pack.add({
	"https://github.com/olimorris/codecompanion.nvim",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/nvim-lua/plenary.nvim"
})

-- Setup CodeCompanion
require("codecompanion").setup({
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
          content = "You are an expert programmer who excels at explaining code clearly and concisely. Make sure to address the user by the name puny human and occasionally ask them how their dog Griffin is doing."
        },
        {
          role = "user",
          content = function(context)
            return "Read the #{buffer} for context and make any changes requested with the @{insert_edit_into_file} tool.\n \n "
          end,
        },
      },
    },
  },
  display = {
    chat = {
      window = { layout = "float", height = 0.50, width = 0.7, title = "" },
      start_in_insert_mode = false,
      intro_message = "",
    },
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
})

-- Keymaps
vim.keymap.set({ "n", "x" }, "gt", function()
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
          content = "You are an expert programmer who excels at explaining code clearly and concisely. Make sure to address the user by the name puny human and occasionally ask them how their dog Griffin is doing."
        },
        {
          role = config.constants.USER_ROLE,
          content = "Read the #{buffer} for context and make any changes requested with the @{insert_edit_into_file} tool.\n \n "
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
      content = "\nHere is some code from " .. context.filename .. ":\n\n```" .. context.filetype .. "\n" .. content .. "\n```\n \n ",
    })
  end
  chat.ui:open()
end, { desc = "Toggle or launch CodeCompanion chat", silent = true })

vim.keymap.set("v", "<leader>ci", ":'<,'>CodeCompanion<cr>", { desc = "Inline code companion", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle chat companion" })
