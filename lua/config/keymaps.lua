-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--

local opts = { silent = true }

vim.keymap.set("i", "jk", "<ESC>", opts)

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

vim.keymap.set("n", "<Leader>a", ":w<CR>", opts)

-- vim.keymap.set("n", "<Leader>gt", "<cmd>lua require('println').todo()<CR>")
vim.keymap.set("n", "<Leader>gt", "<cmd>Lazy reload println.nvim<CR>")
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- floating terminal
local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end

vim.keymap.set("n", "<C-t>", lazyterm, { desc = "Terminal (Root Dir)" })
vim.keymap.set("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>qd",
  '<cmd>call setqflist(filter(getqflist(), {idx -> idx != line(".")-1}))<CR>',
  { noremap = true, silent = true }
)
