-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>", { silent = true })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent Directory" })
-- custom keymaps to automate compilation of C++:
vim.keymap.set("n", "<leader>cc", "<cmd>!g++ % -o %:r<CR>", { desc = "Compile C++" })
vim.keymap.set("n", "<leader>cr", "<cmd>!./%:r<CR>", { desc = "Run C++" })
