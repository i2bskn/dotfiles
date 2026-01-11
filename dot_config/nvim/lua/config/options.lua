-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- 検索設定
opt.ignorecase = true
opt.smartcase = true

-- 行の折り返しをしない
opt.wrap = false
