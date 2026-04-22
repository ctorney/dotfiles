vim.pack.add({
	"https://github.com/lervag/vimtex",
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "tex" },
			group = vim.api.nvim_create_augroup("vimtex_plugins_lazyload", { clear = false }),
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)

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
				--     '_', '-xelatex' -- '_'                = '-xelatex'
				-- }
				vim.g.vimtex_compiler_latexmk = {
					executable = "latexmk",
					options = {
						"-xelatex",
						"-file-line-error",
						"-synctex=1",
						"-interaction=nonstopmode",
					},
				}

				vim.keymap.set("n", "<leader>vc", "<cmd>VimtexCompile<CR>", { desc = "Vimtex Compile" })
				vim.keymap.set("n", "<leader>vv", "<cmd>VimtexView<CR>", { desc = "Vimtex View" })
				vim.keymap.set("n", "<leader>vt", "<cmd>VimtexTocToggle<CR>", { desc = "Vimtex TOC Toggle" })

				vim.keymap.set("n", "<Up>", "gk", { desc = "Move up (visual line)" })
				vim.keymap.set("n", "<Down>", "gj", { desc = "Move down (visual line)" })
				vim.keymap.set("i", "<Up>", "<C-o>gk", { desc = "Move up (visual line) in insert" })
				vim.keymap.set("i", "<Down>", "<C-o>gj", { desc = "Move down (visual line) in insert" })
				vim.keymap.set("v", "<Up>", "gk", { desc = "Move up (visual line) in visual" })
				vim.keymap.set("v", "<Down>", "gj", { desc = "Move down (visual line) in visual" })
			end,
		})
	end,
})
