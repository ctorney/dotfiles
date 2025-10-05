vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "Redo" })
vim.keymap.set("n", "<C-Left>", "<cmd>e #<cr>", { desc = "Previous edited buffer" })
vim.keymap.set("n", "<bs>", "<cmd>b #<cr>", { desc = "Previous edited buffer" })
vim.keymap.set("n", "<s-bs>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape" })
vim.keymap.set("n", "gl", "$", { desc = "End of line" })
vim.keymap.set("n", "gh", "^", { desc = "Start of line" })


vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- movement
vim.keymap.set({ 'n', 'v' }, '<C-Up>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-Down>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-Left>', '<cmd>Treewalker Left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-Right>', '<cmd>Treewalker Right<cr>', { silent = true })
-- vim.keymap.set("n", "<C-Up>", "30k", { desc = "Scroll up" })
-- vim.keymap.set("n", "<C-Down>", "30j", { desc = "Scroll down" })
-- vim.keymap.set("n", "<C-Left>", "30h", { desc = "Move left" })
-- vim.keymap.set("n", "<C-Right>", "30l", { desc = "Move right" })

vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save" })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set({ "n", "x" }, "<leader>/", "gcc", { desc = "Comment line or visual selection", remap = true })
vim.keymap.set("n", "<leader>q", "<cmd>wall<cr><cmd>qall<cr>", { desc = "Save and quit" })
vim.keymap.set("n", "P", "<cmd>pu<cr>", { desc = "Paste into next line" })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set({ "n", "x", "i" }, "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set({ "n", "x", "i" }, "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set({ "n", "x", "i" }, "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set({ "n", "x", "i" }, "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

vim.keymap.set({ "t" }, "<C-t>", "<C-\\><C-n>zt<C-\\><C-n>i", { desc = "Send cursor to top line", remap = true })

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

-- vim.keymap.set("n", "<leader>fe", require("config.functions").ExplorerOpenCurrentDir, { desc = "File explorer" })

vim.keymap.set("n", "<leader>fh", require("config.hosts").hosts_picker, { desc = "SSH to host" })

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "jj", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>")

-- vim.keymap.set({ "n", "v", "i", "x", "t" }, "<c-a>d", function()
-- 	vim.cmd("!shpool detach")
-- end)

-- Jumps to matching pair
vim.keymap.set("n", "mm", "%")

-- Selects until matching pair, e.g. vm - select until matching pair
vim.keymap.set("x", "m", "%")

-- Use with operators, e.g. dm - delete until matching pair
vim.keymap.set("o", "m", "%")

