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
    -- <leader>e (e = explorer) is the de-facto convention for a file-tree toggle
    -- (LazyVim, AstroNvim, kickstart). Going through the leader avoids the clash
    -- <C-b> has with tmux's default prefix, and surfaces the binding in which-key.
    -- Toggling the sidebar is infrequent enough that the extra keystroke is free.
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle file sidebar' },
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
