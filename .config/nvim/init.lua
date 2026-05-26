-- Leader must be set before plugins/mappings are defined.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Inherit the shared, plugin-free base config (also used by plain Vim).
vim.cmd('source ~/.vimrc')

-- The default colorscheme defines Treesitter highlights with GUI colors only,
-- so 24-bit color is required for any highlighting to show (e.g. Markdown).
vim.o.termguicolors = true

-- Bootstrap lazy.nvim (clones itself on first launch).
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugin specs from lua/plugins/.
require('lazy').setup({
  spec = { { import = 'plugins' } },
  checker = { enabled = false },
  change_detection = { notify = false },
})
