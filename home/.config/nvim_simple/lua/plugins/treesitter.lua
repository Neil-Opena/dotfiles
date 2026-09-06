return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'lua', 'vim', 'javascript', 'typescript', 'python', 'markdown' },
      auto_install = true,
      highlight = {
        enable = true,
      },
    },
  },
}
