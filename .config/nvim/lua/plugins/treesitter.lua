
-- ------------------------------------------------------------------------------------------------
--                            TREESITTER AND TREESITTER TEXT OBJECTS
-- ------------------------------------------------------------------------------------------------

vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		version = "main",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		data = {
			run = function(_)
				vim.cmd("TSUpdate")
			end,
		},
	},
})

local augroup = vim.api.nvim_create_augroup("ts_build", { clear = false })
vim.api.nvim_create_autocmd("PackChanged", {
	group = augroup,
	pattern = "*",
	callback = function(e)
		local p = e.data
		local run_task = (p.spec.data or {}).run
		if p.kind ~= "delete" and type(run_task) == "function" then
			pcall(run_task, p)
		end
	end,
})

local langs = {
	"bash",
	"c",
	"diff",
	"html",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"vim",
	"vimdoc",
	"yaml",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = langs,
	callback = function()
		vim.treesitter.start()
	end,
})

require("nvim-treesitter").install(langs)
require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			["@class.outer"] = "<c-v>", -- blockwise
		},
		include_surrounding_whitespace = false,
	},
	move = {
		-- whether to set jumps in the jumplist
		set_jumps = true,
	},
})

vim.keymap.set({ "x", "o" }, "af", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ab", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ib", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ai", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ii", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]f", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ "n", "x", "o" }, "]o", function()
	move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]F", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "][", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[f", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[[", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[F", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[]", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]i", function()
	require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[i", function()
	require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end)

