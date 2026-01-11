-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Space + h/l で行頭・行末移動
map({ "n", "v", "o" }, "<Space>h", "g^", { desc = "Go to head of line" })
map({ "n", "v", "o" }, "<Space>l", "g$", { desc = "Go to end of line" })

-- 検索結果を常に画面中央に (nzz 等)
map("n", "n", "nzz", { desc = "Next search result (centered)" })
map("n", "N", "Nzz", { desc = "Prev search result (centered)" })

-- 置換 (gs)
map("n", "gs", ":%s///g<Left><Left><Left>", { desc = "Global replacement" })
