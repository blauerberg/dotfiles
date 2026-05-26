return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'typescript', 'tsx', 'javascript', 'python',
      'lua', 'vim', 'vimdoc', 'json', 'yaml', 'bash', 'markdown', 'markdown_inline',
    },
    auto_install = false,
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
