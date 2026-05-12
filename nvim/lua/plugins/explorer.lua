return {
  -- Snacks.nvim file explorer - show hidden files
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- show hidden/dotfiles
        ignored = true, -- show gitignored files
      },
    },
  },

  -- Telescope - show hidden files in find_files
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = { "^.git/" }, -- still ignore .git directory
      },
      pickers = {
        find_files = {
          hidden = true, -- show dotfiles
        },
      },
    },
  },
}
