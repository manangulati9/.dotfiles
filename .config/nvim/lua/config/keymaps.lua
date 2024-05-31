-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Add any additional keymaps here
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Move half page down and center view" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Move half page down and center view" })

vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select everything" })

vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true, desc = "Goto next and center view" })

vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true, desc = "Goto previous and center view" })

vim.keymap.set("n", "<leader>o", "o<ESC>", { noremap = true, silent = true, desc = "Add new line below" })

vim.keymap.set("n", "<leader>O", "O<ESC>", { noremap = true, silent = true, desc = "Add new line above" })
