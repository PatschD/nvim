vim.loader.enable()

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.mouse = 'a'
vim.opt.wrap = false
vim.opt.showmode = false

-- Completion
vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }
vim.opt.pumborder = 'single'

-- Keymaps
local opts = { silent = true }
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'jj', '<ESC>', opts)
vim.keymap.set('n', '<S-l>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<Leader>a', ':w<CR>', opts)
vim.keymap.set('n', 'q:', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Trouble keymaps (commands work after plugin loads)
vim.keymap.set('n', '<Leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics' })
vim.keymap.set('n', '<Leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer diagnostics' })

-- LSP keymaps + native completion (attached per buffer)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local o = { buffer = ev.buf, silent = true }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, o)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, o)
    vim.keymap.set('n', 'gi', '<cmd>FzfLua lsp_implementations<cr>', o)
    vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references<cr>', o)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, o)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, o)
    vim.keymap.set('n', '<Leader>ca', '<cmd>FzfLua lsp_code_actions<cr>', o)
    vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format({ async = true }) end, o)
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, o)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, o)
    vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, o)
    vim.keymap.set('n', '<Leader>cd', vim.diagnostic.open_float, o)

    -- Completion handled by blink.cmp
  end,
})

-- Autocmds
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Treesitter hook: run TSUpdate on install/update
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

-------------------------------------------------------------------------------
-- Plugins (everything below requires plugins to be loaded)
-------------------------------------------------------------------------------
vim.pack.add({
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/echasnovski/mini.pairs',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/saghen/blink.indent',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/flash.nvim',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/neovim/nvim-lspconfig',
})

-- Colorscheme
vim.cmd.colorscheme('kanagawa')

-- Which-key
require('which-key').setup()

-- Fzf-lua (fuzzy finder)
require('fzf-lua').register_ui_select()
require('fzf-lua').setup({
  keymap = {
    fzf = {
      ['ctrl-n'] = 'down',
      ['ctrl-p'] = 'up',
    },
  },
})
vim.keymap.set('n', '<Leader>ff', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Grep' })
vim.keymap.set('n', '<Leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Recent files' })
vim.keymap.set('n', '<Leader>fb', '<cmd>FzfLua buffers<cr>', { desc = 'Buffers' })
vim.keymap.set('n', '<Leader>fh', '<cmd>FzfLua help_tags<cr>', { desc = 'Help' })
vim.keymap.set('n', '<Leader>fg', '<cmd>FzfLua git_status<cr>', { desc = 'Git status' })
vim.keymap.set('n', '<Leader>sr', '<cmd>FzfLua resume<cr>', { desc = 'Resume last search' })

-- Oil (file explorer)
require('oil').setup({
  columns = { 'icon', 'size', 'mtime' },
  view_options = { show_hidden = true },
})
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })

-- Completion (blink.cmp)
require('blink.cmp').setup({
  keymap = { preset = 'default' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  completion = {
    documentation = { auto_show = true },
  },
})

-- Git signs
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local o = { buffer = bufnr, silent = true }
    vim.keymap.set('n', ']h', gs.next_hunk, o)
    vim.keymap.set('n', '[h', gs.prev_hunk, o)
    vim.keymap.set('n', '<Leader>hs', gs.stage_hunk, o)
    vim.keymap.set('n', '<Leader>hr', gs.reset_hunk, o)
    vim.keymap.set('n', '<Leader>hp', gs.preview_hunk, o)
    vim.keymap.set('n', '<Leader>hb', gs.blame_line, o)
  end,
})

-- Auto-close pairs
require('mini.pairs').setup()

-- Diffview
vim.keymap.set('n', '<Leader>dv', function()
  local lib = require('diffview.lib')
  if lib.get_current_view() then
    vim.cmd('DiffviewClose')
  else
    vim.cmd('DiffviewOpen')
  end
end, { desc = 'Toggle Diffview' })

-- Lazygit
vim.keymap.set('n', '<Leader>gg', function()
  vim.cmd('tabnew | terminal lazygit')
  vim.cmd('startinsert')
end, { desc = 'Lazygit' })

-- Indent guides
require('blink.indent').setup({
  static = { char = '│' },
  scope = { char = '│' },
})

-- Statusline
require('lualine').setup({
  options = {
    theme = 'kanagawa',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})

-- Flash (jump navigation)
require('flash').setup()
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash treesitter' })

-- Todo comments
require('todo-comments').setup()
vim.keymap.set('n', '<Leader>xt', '<cmd>Trouble todo toggle<cr>', { desc = 'TODOs' })

-- Trouble
require('trouble').setup()

-- Mason
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'gopls',
    'pyright',
    'vtsls',
    'svelte',
    'clangd',
    'tailwindcss',
    'jsonls',
  },
  automatic_enable = true,
})

-- Treesitter: enable highlighting + auto-install parsers
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then return end
    if pcall(vim.treesitter.language.inspect, lang) then
      vim.treesitter.start(ev.buf)
      return
    end
    -- Only install if nvim-treesitter actually has a grammar for this language
    local ok, parsers = pcall(require, 'nvim-treesitter.parsers')
    if ok and parsers[lang] then
      require('nvim-treesitter').install({ lang }):wait(function()
        pcall(vim.treesitter.start, ev.buf)
      end)
    end
  end,
})

-- Formatting (conform.nvim)
require('conform').setup({
  formatters_by_ft = {
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    svelte = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    jsonc = { 'prettierd', 'prettier', stop_after_first = true },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    css = { 'prettierd', 'prettier', stop_after_first = true },
    markdown = { 'prettierd', 'prettier', stop_after_first = true },
    yaml = { 'prettierd', 'prettier', stop_after_first = true },
    python = { 'black' },
    lua = { 'stylua' },
    go = { 'gofumpt', 'goimports' },
    c = { lsp_format = 'fallback' },
    cpp = { lsp_format = 'fallback' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
})
