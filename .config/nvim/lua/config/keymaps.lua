vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "Redo" })
vim.keymap.set("n", "<bs>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<s-bs>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape" })
vim.keymap.set("n", "gl", "$", { desc = "End of line" })
vim.keymap.set("n", "gh", "^", { desc = "Start of line" })
vim.keymap.set("n", "<C-Up>", "30k", { desc = "Scroll up" })
vim.keymap.set("n", "<C-Down>", "30j", { desc = "Scroll down" })
vim.keymap.set("n", "<C-Left>", "30h", { desc = "Move left" })
vim.keymap.set("n", "<C-Right>", "30l", { desc = "Move right" })
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save" })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set({ "n", "x" }, "<leader>/", "gcc", { desc = "Comment line or visual selection", remap = true })
vim.keymap.set("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete buffer" })

vim.keymap.set("n", "<leader>td", function()
	local current_config = vim.diagnostic.config()
	if current_config == nil then
		return
	end
	local virtual_text = current_config.virtual_text
	vim.diagnostic.config({
		virtual_text = not (virtual_text == true),
	})
end, { desc = "Toggle virtual text" })

local functions = require("functions")
vim.keymap.set("n", "<leader>fe", functions.ExplorerOpenCurrentDir, { desc = "File explorer" })
