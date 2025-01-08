return {
  {
    "ValJed/marks.nvim",
    branch = "feat-telescope-support-for-listing-marks",
    event = "BufRead",
    config = function()
      require("telescope").load_extension("marks_nvim")
      require("marks").setup({
        bookmark_0 = {
          sign = "▶",
          annotate = false,
        },
      })
      vim.api.nvim_set_keymap("n", "<leader>ma", "<Plug>(Marks-set-bookmark0)", { desc = "Set mark at current line" })
      vim.api.nvim_set_keymap(
        "n",
        "<leader>mc",
        "<Plug>(Marks-delete-bookmark0)",
        { desc = "Delete mark at current line" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>md",
        "<Plug>(Marks-delete-bookmark)",
        { desc = "Delete mark at current line" }
      )
      vim.api.nvim_set_keymap("n", "<leader>mp", "<Plug>(Marks-prev-bookmark0)", { desc = "Go to previous mark" })
      vim.api.nvim_set_keymap("n", "<leader>mn", "<Plug>(Marks-next-bookmark0)", { desc = "Go to next mark" })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        ["<leader>m"] = { name = "+marks" },
      },
    },
  },
}
