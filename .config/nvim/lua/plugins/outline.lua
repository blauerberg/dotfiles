return {
  -- Symbol outline sidebar: a live "map" of the file (functions, classes,
  -- fields) you can keep open while reading and jump from.
  'stevearc/aerial.nvim',
  cmd = { 'AerialToggle', 'AerialOpen', 'AerialNavToggle' },
  keys = {
    { '<leader>o', '<cmd>AerialToggle<cr>', desc = 'Outline (symbols)' },
  },
  opts = {
    -- Prefer LSP symbols; fall back to Treesitter for buffers without a server.
    backends = { 'lsp', 'treesitter' },
    layout = { default_direction = 'right' },
  },
}
