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
    -- When opening a file, neo-tree reuses the last-focused normal window
    -- (open_files_in_last_window, on by default). If you last touched the
    -- aerial outline on the right, the file would load *there* instead of the
    -- code window. Listing aerial's filetype makes neo-tree skip that window
    -- when picking where to open. tbl_deep_extend("force") overwrites this list
    -- by index rather than appending, so the defaults are restated here.
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'edgy', 'aerial' },
    filesystem = {
      -- Reveal and highlight the file in the current buffer as you switch buffers,
      -- like VSCode's explorer tracking the active editor.
      follow_current_file = { enabled = true },
      -- Refresh the tree when files change on disk (create/delete/rename).
      use_libuv_file_watcher = true,
      -- Take over directory buffers (e.g. `nvim .`) instead of the netrw listing.
      hijack_netrw_behavior = 'open_default',
      filtered_items = {
        -- hide_dotfiles judges purely by a leading '.', ignoring git status, so
        -- it hid tracked dotfiles like .github/.gitignore. Turn it off and let
        -- hide_gitignored (default true) be the thing that hides ignored files.
        hide_dotfiles = false,
        -- .git isn't gitignored, so it would now show; hide it by name. Note
        -- neo-tree index-merges this list over its default { '.DS_Store',
        -- 'thumbs.db' }, so the effective value is { '.git', 'thumbs.db' }.
        hide_by_name = { '.git' },
      },
      -- Search (the default '#' fuzzy_sorter) collects matches in find-command
      -- (fd) output order and stops at this many, then sorts by fzy score. The
      -- default 50 truncates before scoring, so a file deep in traversal order
      -- can be cut even when it scores highest. 1000 keeps the target in the
      -- collected set so the score sort can surface it.
      search_limit = 1000,
    },
  },
}
