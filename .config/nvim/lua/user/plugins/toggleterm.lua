return {
"akinsho/toggleterm.nvim",
opts = {
  size = vim.o.columns * 0.01,
  open_mapping = [[<F7>]],
  shading_factor = 2,
  direction = "horizontal",
  float_opts = {
    border = "curved",
    highlights = { border = "Normal", background = "Normal" },
  },
},
 init = function() 
  --vim.api.nvim_command([[0ToggleTerm]])
  --vim.api.nvim_command([[1ToggleTerm]])

--    vim.api.nvim_exec([[1ToggleTerm
--                        2ToggleTerm]], true)

--  vim.cmd([[1ToggleTerm]])
end,

}
