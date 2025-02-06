-- [[ Keymaps ]]

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
