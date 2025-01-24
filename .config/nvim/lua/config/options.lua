-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.everforest_transparent_background = 2
vim.g.everforest_float_style = "dim"
vim.g.everforest_background = "hard"
vim.opt.cursorcolumn = false
vim.opt.signcolumn = "number" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.pumblend = 10 -- float transparency
vim.opt.textwidth = 0
vim.opt.wrap = true
vim.opt.linebreak = true
vim.b.autoformat = false
vim.g.lazyvim_python_lsp = "pyright"
