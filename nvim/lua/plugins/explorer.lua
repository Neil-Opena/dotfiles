return {
  -- Snacks.nvim picker/explorer - show hidden files
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- show hidden/dotfiles in explorer + file search
        no_ignore = true, -- ignore .gitignore rules, show gitignored files
      },
    },
  },
}
