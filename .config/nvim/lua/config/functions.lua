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

-- Assuming Snacks is already required/imported
function M.show_image()
	local image_path = "/Users/colin.torney/workspace/test/im.png"
	local placement = require("snacks.image.placement")

	local buffer = vim.api.nvim_get_current_buf()
	vim.notify("show_image")
	vim.notify(buffer)

	local cursor = vim.api.nvim_win_get_cursor(0)
	local pos = { cursor[1], cursor[2] }
	local opts = { inline = true, pos = pos }
	local image = placement.new(buffer, image_path, opts)

	-- Get the terminal buffer number
	local term_buf = vim.api.nvim_get_current_buf()
	-- Create a namespace
	local ns = vim.api.nvim_create_namespace("my_terminal_marks")

	-- Add an extmark with virtual text
	vim.api.nvim_buf_set_extmark(term_buf, ns, 0, 0, {
		virt_text = { { "Hello from extmark!", "Comment" } },
		virt_text_pos = "right_align", -- or "eol" or "overlay"
	})
	-- local TermImage = require("config.terminal")
	-- -- Create a new image instance
	-- local image = TermImage.new(image_path)
	--  image.sent = false
	-- image:send()

	-- -- local TermPlacement = require("snacks.image.placement")
	-- -- Create a placement for the image
	-- local placement = TermPlacement.new({
	-- 	image = image,
	-- 	buffer = vim.api.nvim_get_current_buf(),
	-- 	row = vim.fn.line(".") - 1, -- current line (0-based)
	-- 	col = 0, -- start of line
	-- })

	-- Place the image
	-- image:place(placement)
end

return M
