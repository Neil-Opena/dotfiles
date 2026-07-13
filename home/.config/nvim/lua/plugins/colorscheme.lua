return {
  -- VSCode Dark+ theme
  {
    "Mofiqul/vscode.nvim",
    opts = {
      transparent = false,
      italic_comments = true,
    },
  },

  -- Kanagawa theme
  {
    "rebelot/kanagawa.nvim",
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },

  -- Configure LazyVim to load vscode
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
