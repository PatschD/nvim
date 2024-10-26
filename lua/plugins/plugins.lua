return {
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
  { "rose-pine/neovim", name = "rose-pine" },
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
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "andrewferrier/debugprint.nvim",
    opts = {},
    dependencies = {
      "echasnovski/mini.nvim", -- Needed to enable :ToggleCommentDebugPrints for NeoVim 0.9
    },
    -- Remove the following line to use development versions,
    -- not just the formal releases
    version = "*",
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
