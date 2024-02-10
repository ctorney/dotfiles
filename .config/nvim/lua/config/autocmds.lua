-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- vim.cmd 'autocmd BufRead,BufNewFile *.ino set filetype=c'
-- vim.api.nvim_create_autocmd("BufRead", "BufNewFile", true, function()
--   vim.cmd('setlocal formatoptions-=cro')
-- end)
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.ino",
  command = "set filetype=c",
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})
