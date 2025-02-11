return {
	{
		"lervag/vimtex",
		ft = { "tex" },
		config = function()
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
			-- set line wrapping on
			vim.g.wrap =
				true, vim.cmd([[
      nmap <Up> gk
      nmap <Down> gj
      imap <Up> <C-o>gk
      imap <Down> <C-o>gj
      vmap <Up> gk
      vmap <Down> gj
      nmap <leader>vc :VimtexCompile<CR>
      nmap <leader>vv :VimtexView<CR>
      nmap <leader>vt :VimtexTocToggle<CR>
      ]])
		end,
	},
}
