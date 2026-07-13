-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Comment toggle (VSCode-style Ctrl+/)
-- Note: Ctrl+/ is seen as Ctrl+_ in terminals
vim.keymap.set("n", "<C-_>", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("v", "<C-_>", "gc", { desc = "Toggle comment", remap = true })
