return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})

      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", "<leader>ht", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Toggle harpoon telescope window" })
      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():append()
      end, { desc = "Append file to harpoon" })
      vim.keymap.set("n", "<leader>hc", function()
        harpoon:list():clear()
      end, { desc = "Clear harpoon" })
      vim.keymap.set("n", "<leader>hh", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Toggle harpoon quick menu"})
      vim.keymap.set("n", "<leader>j", function()
        harpoon:list():prev()
      end, { desc = "Previous harpoon file" })
      vim.keymap.set("n", "<leader>k", function()
        harpoon:list():next()
      end, { desc = "Next harpoon file" })
      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end, { desc = "Select harpoon window 1" })
      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end, { desc = "Select harpoon window 2" })
      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end, { desc = "Select harpoon window 3" })
      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end, { desc = "Select harpoon window 4" })
    end,
  },

  {
  'tomasky/bookmarks.nvim',
  -- after = "telescope.nvim",
  event = "BufEnter",
  config = function()
     require('telescope').load_extension('bookmarks') 
      require('bookmarks').setup(
        {
          -- sign_priority = 8,  --set bookmark sign priority to cover other sign
          save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
          keywords =  {
            ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
            ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
            ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
            ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
          },
          on_attach = function(bufnr)
            local bm = require "bookmarks"
            local map = vim.keymap.set
            map("n","mm",bm.bookmark_toggle) -- add or remove bookmark at current line
            map("n","mi",bm.bookmark_ann) -- add or edit mark annotation at current line
            map("n","mc",bm.bookmark_clean) -- clean all marks in local buffer
            map("n","mn",bm.bookmark_next) -- jump to next mark in local buffer
            map("n","mp",bm.bookmark_prev) -- jump to previous mark in local buffer
            map("n","ml",bm.bookmark_list) -- show marked file list in quickfix window
          end,

          signs = {
              add = { hl = "BookMarksAdd", text = "▶", numhl = "BookMarksAddNr", linehl = "BookMarksAddLn" },
              ann = { hl = "BookMarksAnn", text = "▷", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
          },
        }
      )
    end,
},

  -- {
  --   "chentoast/marks.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("marks").setup({
  --       bookmark_0 = {
  --         sign = "▶",
  --         -- sign = "▷▶",
  --         annotate = false,
  --       },
  --     })
  --     vim.api.nvim_set_keymap("n", "<leader>ma", "<Plug>(Marks-set-bookmark0)", { desc = "Set mark at current line" })
  --     vim.api.nvim_set_keymap("n", "<leader>mc", "<Plug>(Marks-delete-bookmark0)", { desc = "Delete mark at current line" })
  --     vim.api.nvim_set_keymap("n", "<leader>md", "<Plug>(Marks-delete-bookmark)", { desc = "Delete mark at current line" })
  --     vim.api.nvim_set_keymap("n", "<leader>o", "<Plug>(Marks-prev-bookmark0)", { desc = "Go to previous mark" })
  --     vim.api.nvim_set_keymap("n", "<leader>p", "<Plug>(Marks-next-bookmark0)", { desc = "Go to next mark" })
  --   end,
  -- },
  {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      ["<leader>h"] = { name = "+harpoon" },
      ["<leader>m"] = { name = "+marks" },
    },
  },
}
}
