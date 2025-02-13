local M = {}

function M.ExplorerOpenCurrentDir()
	local Actions = require("snacks.explorer.actions")
	local Tree = require("snacks.explorer.tree")
	local explorer = Snacks.picker.get({ source = "explorer" })[1] or Snacks.picker.explorer()

	local cwd = explorer:cwd()
	local file = vim.fs.normalize(vim.api.nvim_buf_get_name(0))
	if file ~= "" then
		cwd = vim.fs.dirname(file)
	end
	explorer:set_cwd(cwd)
	return explorer
end
return M
