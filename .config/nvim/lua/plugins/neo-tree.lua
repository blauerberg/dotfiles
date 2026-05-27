return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    -- File-type icons. These render as boxes without a Nerd Font installed in the
    -- terminal; the tree is fully usable either way.
    'nvim-tree/nvim-web-devicons',
  },
  cmd = 'Neotree',
  keys = {
    -- VSCode's Cmd/Ctrl-B sidebar toggle. <C-b> is a clean control byte so it
    -- reaches nvim through integrated terminals, but note two costs: it shadows
    -- the built-in page-back scroll (<C-u> half-page still works), and inside tmux
    -- it collides with tmux's default C-b prefix, which grabs it first.
    { '<C-b>', '<cmd>Neotree toggle<cr>', desc = 'Toggle file sidebar' },
  },
  opts = {
    window = { position = 'left' },
    filesystem = {
      -- Reveal and highlight the file in the current buffer as you switch buffers,
      -- like VSCode's explorer tracking the active editor.
      follow_current_file = { enabled = true },
      -- Refresh the tree when files change on disk (create/delete/rename).
      use_libuv_file_watcher = true,
      -- Take over directory buffers (e.g. `nvim .`) instead of the netrw listing.
      hijack_netrw_behavior = 'open_default',
    },
  },
}
