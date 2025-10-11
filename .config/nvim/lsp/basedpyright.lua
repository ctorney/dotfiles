return {
	cmd = {
		"basedpyright-langserver",
		"--stdio",
	},
	filetypes = {
		"python",
	},
	root_markers = {
		".git",
		"Pipfile",
		"pyproject.toml",
		"pyrightconfig.json",
		"requirements.txt",
		"setup.cfg",
		"setup.py",
	},
	-- https://microsoft.github.io/pyright/#/settings?id=pyright-settings
	settings = {
		basedpyright = {
			-- strict = true,
    typeCheckingMode = "basic", -- "off", "basic", "strict"
      -- pythonPath = vim.fn.expand("$CONDA_PREFIX") .. "/bin/python",
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},

	single_file_support = true,
}
