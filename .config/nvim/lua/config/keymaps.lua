vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "Redo" })
vim.keymap.set("n", "<bs>", "<cmd>b #<cr>", { desc = "Previous edited buffer" })
vim.keymap.set("n", "gl", "$", { desc = "End of line" })
vim.keymap.set("n", "gh", "^", { desc = "Start of line" })


vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- movement
vim.keymap.set({ 'n', 'v' }, '<C-Up>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-Down>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-Left>', '<cmd>Treewalker Left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-Right>', '<cmd>Treewalker Right<cr>', { silent = true })

vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save" })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set({ "n", "x" }, "<leader>/", "gcc", { desc = "Comment line or visual selection", remap = true })
vim.keymap.set("n", "<leader>q", "<cmd>wall<cr><cmd>qall<cr>", { desc = "Save and quit" })


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

vim.keymap.set("x", "<leader>w", "<cmd>echo wordcount().visual_words<CR>", { desc = "Visual word count" })
vim.keymap.set("n", "<leader>fe", require("config.functions").ExplorerOpenCurrentDir, { desc = "File explorer" })


-- Jumps to matching pair
vim.keymap.set("n", "mm", "%")
vim.keymap.set("x", "m", "%")
vim.keymap.set("o", "m", "%")

