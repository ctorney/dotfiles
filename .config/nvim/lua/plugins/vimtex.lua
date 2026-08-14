

vim.pack.add({
	"https://github.com/lervag/vimtex",
})

-- VimTeX configuration (no setup function needed)
vim.g.vimtex_view_general_viewer = "open"
vim.g.vimtex_view_enabled = 1
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk_engines = {
	pdflatex = "-pdf",
	lualatex = "-lualatex", 
	xelatex = "-xelatex",
	context = "-pdf",
	platex = "-pdfdvi",
	uplatex = "-pdfdvi",
	["_"] = "-xelatex",
}

vim.g.vimtex_compiler_latexmk = {
	executable = "latexmk",
	options = {
		"-xelatex",
		"-file-line-error", 
		"-synctex=1",
		"-interaction=nonstopmode",
	},
}

-- Set line wrapping on
vim.opt.wrap = true

-- Keymaps (use Lua instead of vim.cmd)
local keymap = vim.keymap.set

-- Movement keymaps for wrapped lines
keymap('n', '<Up>', 'gk', { noremap = true })
keymap('n', '<Down>', 'gj', { noremap = true })
keymap('i', '<Up>', '<C-o>gk', { noremap = true })
keymap('i', '<Down>', '<C-o>gj', { noremap = true })
keymap('v', '<Up>', 'gk', { noremap = true })
keymap('v', '<Down>', 'gj', { noremap = true })

-- VimTeX keymaps
keymap('n', '<leader>vc', ':VimtexCompile<CR>', { noremap = true })
keymap('n', '<leader>vv', ':VimtexView<CR>', { noremap = true })
keymap('n', '<leader>vt', ':VimtexTocToggle<CR>', { noremap = true })


