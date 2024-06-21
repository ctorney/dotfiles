-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- --keywordprg
local Util = require("lazyvim.util")
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "Redo" })
vim.keymap.set("n", "<bs>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<s-bs>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader>/", "gcc", { desc = "Comment" })
-- vim.keymap.set("v", "<leader>/", "gc", { desc = "Visual comment" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape" })
vim.keymap.set("n", '<leader><CR>', "i<Enter><Esc>", {desc = "Add line break"} )
vim.keymap.set("n", "<C-/>", "<cmd>lua require('FTerm').toggle()<CR>", { desc = "Toggle FTerm" })
vim.keymap.set("t", "<C-/>", "<cmd>lua require('FTerm').toggle()<CR>", { desc = "Toggle FTerm" })
vim.keymap.set('n', '<C-h>', "<cmd>lua require('smart-splits').move_cursor_left()<cr>")
vim.keymap.set('n', '<C-j>', "<cmd>lua require('smart-splits').move_cursor_down()<cr>")
vim.keymap.set('n', '<C-k>', "<cmd>lua require('smart-splits').move_cursor_up()<cr>")
vim.keymap.set('n', '<C-l>', "<cmd>lua require('smart-splits').move_cursor_right()<cr>")

