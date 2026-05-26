return {
  'maxmx03/solarized.nvim',
  -- Load during startup and before other plugins so the colorscheme is ready
  -- before any UI is drawn.
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    vim.o.background = 'dark'
    require('solarized').setup(opts)
    vim.cmd.colorscheme('solarized')
  end,
}
