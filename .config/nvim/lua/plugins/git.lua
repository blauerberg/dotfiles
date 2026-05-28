return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- Show the commit that last touched the current line as faint virtual
      -- text at end of line (after gitsigns' own delay). Toggle ad hoc with
      -- :Gitsigns toggle_current_line_blame when it gets noisy.
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map('n', ']h', function() gs.nav_hunk('next') end, 'Next hunk')
        map('n', '[h', function() gs.nav_hunk('prev') end, 'Prev hunk')
        map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame line')
        -- Full-file blame in a synced side window (GitHub-style: every line
        -- annotated with hash/author/date). gs.blame() only ever opens, so
        -- toggle by closing an already-open 'gitsigns-blame' window first.
        map('n', '<leader>gB', function()
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'gitsigns-blame' then
              vim.api.nvim_win_close(win, false)
              return
            end
          end
          gs.blame()
        end, 'Toggle blame (full file)')
      end,
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File history' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Repo history' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Close diff view' },
    },
    opts = {},
  },
}
