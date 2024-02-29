return {

--   {
--   'tomasky/bookmarks.nvim',
--   -- after = "telescope.nvim",
--   event = "BufEnter",
--   config = function()
--      require('telescope').load_extension('bookmarks') 
--       require('bookmarks').setup(
--         {
--           -- sign_priority = 8,  --set bookmark sign priority to cover other sign
--           save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
--           keywords =  {
--             ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
--             ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
--             ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
--             ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
--           },
--           on_attach = function(bufnr)
--             local bm = require "bookmarks"
--             vim.api.nvim_set_keymap("n", "<leader>mm", "<cmd>lua require('bookmarks').bookmark_toggle()<CR>", { noremap = true, silent = true, desc = "Toggle bookmark at current line" })
--             vim.api.nvim_set_keymap("n", "<leader>mi", "<cmd>lua require('bookmarks').bookmark_ann()<CR>", { noremap = true, silent = true, desc = "Add or edit mark annotation at current line" })
--             vim.api.nvim_set_keymap("n", "<leader>mc", "<cmd>lua require('bookmarks').bookmark_clean()<CR>", { noremap = true, silent = true, desc = "Clean all marks in local buffer" })
--             vim.api.nvim_set_keymap("n", "<leader>mn", "<cmd>lua require('bookmarks').bookmark_next()<CR>", { noremap = true, silent = true, desc = "Jump to next mark in local buffer" })
--             vim.api.nvim_set_keymap("n", "<leader>mp", "<cmd>lua require('bookmarks').bookmark_prev()<CR>", { noremap = true, silent = true, desc = "Jump to previous mark in local buffer" })
--           end,
--
--           signs = {
--               add = { hl = "BookMarksAdd", text = "▶", numhl = "BookMarksAddNr", linehl = "BookMarksAddLn" },
--               ann = { hl = "BookMarksAnn", text = "▷", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
--           },
--         }
--       )
--     end,
-- },
  {
    "ValJed/marks.nvim",
    branch = "feat-telescope-support-for-listing-marks",
    event = "BufRead",
    config = function()
      require("telescope").load_extension("marks_nvim")
      require("marks").setup({
        bookmark_0 = {
          sign = "▶",
          -- sign = "▷▶",
          annotate = false,
        },
      })
      vim.api.nvim_set_keymap("n", "<leader>ma", "<Plug>(Marks-set-bookmark0)", { desc = "Set mark at current line" })
      vim.api.nvim_set_keymap("n", "<leader>mc", "<Plug>(Marks-delete-bookmark0)", { desc = "Delete mark at current line" })
      vim.api.nvim_set_keymap("n", "<leader>md", "<Plug>(Marks-delete-bookmark)", { desc = "Delete mark at current line" })
      vim.api.nvim_set_keymap("n", "<leader>mp", "<Plug>(Marks-prev-bookmark0)", { desc = "Go to previous mark" })
      vim.api.nvim_set_keymap("n", "<leader>mn", "<Plug>(Marks-next-bookmark0)", { desc = "Go to next mark" })
    end,
  },
  {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      ["<leader>m"] = { name = "+marks" },
    },
  },
}
}
