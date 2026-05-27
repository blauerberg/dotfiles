return {
  'mrjones2014/legendary.nvim',
  dependencies = {
    -- fzf-lua backs vim.ui.select so the palette is a fuzzy finder rather than
    -- the plain numbered prompt; loading it here guarantees setup before we
    -- register the ui.select handler.
    'ibhagwan/fzf-lua',
    -- sqlite.lua powers legendary's frecency sort (frequency + recency, persisted
    -- across sessions) -- the actual "recently used floats to the top" behaviour.
    -- Without it legendary silently falls back to only floating the single most
    -- recently selected item. macOS ships libsqlite3, which it loads over FFI.
    'kkharji/sqlite.lua',
  },
  keys = {
    -- Everyday command palette. Sorted most-recently-used first (see opts), so it
    -- behaves like VSCode's palette: recent actions float to the top, typing
    -- fuzzy-matches. Limited to registered/imported items (lazy `keys` below),
    -- not every Ex command -- the exhaustive search lives on <C-S-p> in finder.lua.
    { '<C-p>', function() require('legendary').find() end, desc = 'Command palette (recent first)' },
  },
  opts = {
    -- frecency (frequency + recency) sorting is on by default and, with sqlite.lua
    -- present, ranks items VSCode-style: things you run often/recently float up,
    -- and it persists across sessions. most_recent_first stays as the fallback for
    -- the no-sqlite case (it only floats the single most recent item). Note that
    -- only items executed *through the palette* update these scores.
    sort = { most_recent_first = true },
    -- Auto-import every keymap declared via a lazy.nvim `keys` spec (finder, git,
    -- outline), so they populate the palette without re-declaring them here.
    extensions = { lazy_nvim = true },
  },
  config = function(_, opts)
    -- Route vim.ui.select through fzf-lua before legendary builds its picker. This
    -- also upgrades other vim.ui.select prompts (e.g. LSP code actions) to fzf-lua.
    require('fzf-lua').register_ui_select()
    require('legendary').setup(opts)
  end,
}
