vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.inccommand = "nosplit"
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.laststatus = 3



vim.api.nvim_create_autocmd(
  { "InsertLeavePre", "TextChanged", "TextChangedP" },
  {
    pattern = "*",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      if vim.api.nvim_buf_get_option(buf, "modifiable")
         and not vim.api.nvim_buf_get_option(buf, "readonly") then
        -- Save the buffer silently (no messages)
        vim.cmd('silent! update')
      end
    end,
  }
)

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("last-location", { clear = true }),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.FCMacro",
	command = "set filetype=python",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.ino",
	command = "set filetype=c",
})

vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		if vim.bo.filetype == "REPL" then
			vim.cmd("startinsert")
		end
	end,
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

			if vim.g.have_nerd_font then
				local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
				local diagnostic_signs = {}
				for type, icon in pairs(signs) do
					diagnostic_signs[vim.diagnostic.severity[type]] = icon
				end
				vim.diagnostic.config({
					signs = { text = diagnostic_signs },
					virtual_text = false,
					underline = false,
				})
			end
local lsp_configs = {}

for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
  local server_name = vim.fn.fnamemodify(f, ':t:r')
  table.insert(lsp_configs, server_name)
end

vim.lsp.enable(lsp_configs)

-- vim.api.nvim_create_autocmd("BufLeave", {
-- 	group = vim.api.nvim_create_augroup("codecompanion_unlist", { clear = true }),
-- 	pattern = "*CodeCompanion*",
-- 	callback = function(ev)
-- 		local buf = ev.buf
-- 		if vim.api.nvim_buf_is_valid(buf) then
-- 			pcall(function()
-- 				vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
-- 			end)
-- 		end
-- 	end,
-- })
