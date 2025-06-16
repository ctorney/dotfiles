-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- function ipython()
--   local pane_id = os.getenv("WEZTERM_PANE")
--   local cmdstring = string.format(
--     [[wezterm cli split-pane --right --percent 30 -- ipython -i -c 'from qbstyles import mpl_style;mpl_style("dark")' && wezterm cli activate-pane --pane-id %s]],
--     pane_id
--   )
--   io.popen(cmdstring)
-- end

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.FCMacro",
  command = "set filetype=python",
})
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

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "mail",
  callback = function()
    vim.opt_local.textwidth = 0
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- vim.api.nvim_create_user_command("Ipython", ipython, { bang = true, nargs = "?" })

-- vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "BufEnter" }, {
--   callback = function()
--     vim.cmd("silent! !tmux set status off")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
--   callback = function()
--     vim.cmd("silent! !tmux set status on")
--   end,
-- })
