-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Move to window and tmux using the <ctrl> hjkl keys
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local options = { noremap = true, silent = true }
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Go to left window" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Go to down window" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Go to up window" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Go to right window" })
