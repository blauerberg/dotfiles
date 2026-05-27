return {
  'mrjones2014/legendary.nvim',
  -- legendary renders through vim.ui.select; fzf-lua backs that so the palette is
  -- a fuzzy finder rather than the plain numbered prompt. Loading fzf-lua as a
  -- dependency guarantees it is set up before we register the ui.select handler.
  dependencies = { 'ibhagwan/fzf-lua' },
  keys = {
    -- Everyday command palette. Sorted most-recently-used first (see opts), so it
    -- behaves like VSCode's palette: recent actions float to the top, typing
    -- fuzzy-matches. Limited to registered/imported items (lazy `keys` below),
    -- not every Ex command -- the exhaustive search lives on <C-S-p> in finder.lua.
    { '<C-p>', function() require('legendary').find() end, desc = 'Command palette (recent first)' },
  },
  opts = {
    -- Float the most recently executed item to the top. Session-scoped and
    -- dependency-free; persistent frecency would additionally require sqlite.lua.
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
