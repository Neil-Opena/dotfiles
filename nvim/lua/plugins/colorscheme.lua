return {
  -- VS Code Dark+ theme
  {
    "Mofiqul/vscode.nvim",
    opts = {
      style = "dark",
      transparent = false,
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
