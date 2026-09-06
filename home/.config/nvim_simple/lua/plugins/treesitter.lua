return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'lua', 'vim', 'javascript', 'typescript', 'python', 'markdown', 'tsx' },
      auto_install = true,
      highlight = {
        enable = true,
      },
    },
  },
  {
    'davidmh/mdx.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
