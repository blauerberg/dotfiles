return {
  -- Pin the enclosing function/class signature to the top of the window while
  -- scrolling, so the context of the line being read never goes off-screen.
  'nvim-treesitter/nvim-treesitter-context',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    max_lines = 3, -- cap the sticky header so it never eats the viewport
  },
  keys = {
    {
      '[c',
      function() require('treesitter-context').go_to_context() end,
      desc = 'Jump to context',
    },
  },
}
