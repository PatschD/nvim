return {
  -- Using Lazy
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
  },
  { "mistricky/codesnap.nvim", build = "make" },
  { "sindrets/diffview.nvim" },

  {
    "stevearc/oil.nvim",
    opts = {
      columns = {
        "icon",
        "size",
        "mtime",
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>/", LazyVim.pick("live_grep_glob"), desc = "Grep Glob (Root Dir)" },
    },
  },

  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },

  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
