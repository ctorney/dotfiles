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

function M.SnacksMarksman()
  local marksman = require("marksman")
  local marks = marksman.get_marks()

  local results = {}
  for name, mark in pairs(marks) do
    table.insert(results, {
      text = name,
      file = mark.file,
      pos = { tonumber(mark.line) or 1, tonumber(mark.col) or 1 },
      display = string.format("%s %s:%d", name, vim.fn.fnamemodify(mark.file, ":~:."), mark.line),
    })
  end

  return results
end

return M
