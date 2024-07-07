-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- vim.cmd 'autocmd BufRead,BufNewFile *.ino set filetype=c'
-- vim.api.nvim_create_autocmd("BufRead", "BufNewFile", true, function()
--   vim.cmd('setlocal formatoptions-=cro')
-- end)

function ipython2() 
  local cmdstring = [[wezterm cli spawn --new-window -- ipython -i -c 'from qbstyles import mpl_style;mpl_style("dark")' ]]
  local handle = io.popen(cmdstring)
  ipython_pane = (handle:read("*a"):gsub("^%s*(.-)%s*$", "%1"))
  -- create a vim function for setting the slime config so that it points to the correct pane
  vim.api.nvim_exec([[
  function! SlimeOverrideConfig()
  let b:slime_config = {}
  let b:slime_config["pane_id"] = ]] .. ipython_pane .. [[ 
  endfunction]], false)
  -- set the slime config
  vim.api.nvim_exec([[:SlimeConfig]], false)  
  return
end

function ipython()
  local cmdstring = [[tmux split-window -h -l 30% -- ipython -i -c 'from qbstyles import mpl_style;mpl_style("dark")']]
  local handle = io.popen(cmdstring)
  return
end

function ipython3() 
  local cmdstring = [[wezterm cli split-pane --right --percent 30 -- ipython -i -c 'from qbstyles import mpl_style;mpl_style("dark")' ]]
  -- local handle = io.popen(cmdstring)
  -- ipython_pane = (handle:read("*a"):gsub("^%s*(.-)%s*$", "%1"))
  -- create a vim function for setting the slime config so that it points to the correct pane
  -- vim.api.nvim_exec([[
  -- function! SlimeOverrideConfig()
  -- let b:slime_config = {}
  -- let b:slime_config["pane_id"] = ]] .. ipython_pane .. [[ 
  -- endfunction]], false)
  -- set the slime config
  -- vim.api.nvim_exec([[:SlimeConfig]], false)  
  -- return
  local handle = io.popen(cmdstring)
    ipython_pane = (handle:read("*a"):gsub("^%s*(.-)%s*$", "%1"))
    -- create a vim function for setting the slime config so that it points to the correct pane
    vim.api.nvim_exec([[
      function! SlimeOverrideConfig()
      let b:slime_config = {}
      let b:slime_config["pane_id"] = ]] .. ipython_pane .. [[ 
      endfunction]], false)
      -- set the slime config
      vim.api.nvim_exec([[:SlimeConfig]], false)
  return
end

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

vim.api.nvim_create_user_command('Ipython', ipython, {bang = true, nargs = '?'})
