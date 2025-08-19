-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Move half page down and center view" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Move half page down and center view" })
-- vim.keymap.set("n", "<leader>e", function()
--   require("oil").toggle_float(".")
-- end, { noremap = true, silent = true, desc = "Open file explorer" })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Goto next and center view" })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Goto previous and center view" })
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, silent = true, desc = "Paste current buffer" })
vim.keymap.set("n", "<leader>o", "o<ESC>", { noremap = true, silent = true, desc = "Add new line below" })
vim.keymap.set("n", "<leader>O", "O<ESC>", { noremap = true, silent = true, desc = "Add new line above" })
