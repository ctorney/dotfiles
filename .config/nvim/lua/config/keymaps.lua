-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- --keywordprg
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "Redo" })
vim.keymap.set("n", "<bs>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<s-bs>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader>/", "gcc", { desc = "Comment" })
-- vim.keymap.set("v", "<leader>/", "gc", { desc = "Visual comment" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape" })
