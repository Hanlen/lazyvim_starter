-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move cursor to left window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move cursor to right window" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Move cursor to down window" })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Move cursor to up window" })
