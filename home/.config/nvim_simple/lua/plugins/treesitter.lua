return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ensure_installed = { 'lua', 'vim', 'javascript', 'typescript', 'python', 'markdown', 'tsx' }
      require('nvim-treesitter').install(ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    'davidmh/mdx.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
