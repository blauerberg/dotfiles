-- Leader must be set before plugins/mappings are defined.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Inherit the shared, plugin-free base config (also used by plain Vim).
vim.cmd('source ~/.vimrc')

-- The default colorscheme defines Treesitter highlights with GUI colors only,
-- so 24-bit color is required for any highlighting to show (e.g. Markdown).
vim.o.termguicolors = true

-- Built-in dark colorscheme; higher contrast than solarized, which reads as
-- washed out on a dimmed display. No plugin needed (ships with Neovim).
vim.cmd.colorscheme('slate')

-- slate's comments are #666666, which disappears on a dimmed display. Re-run
-- the override whenever the colorscheme loads so it survives a :colorscheme.
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'Comment', { fg = '#b0b0b0' })
  end,
})
vim.api.nvim_set_hl(0, 'Comment', { fg = '#b0b0b0' })

-- Treesitter-based folding: the syntax tree supplies fold ranges, so functions
-- and blocks can be collapsed to read a file's structure top-down. Files open
-- fully expanded (foldlevelstart=99); use zM to collapse all, zR to expand,
-- za to toggle the fold under the cursor. Core Neovim feature (no plugin); on
-- filetypes without a parser foldexpr returns no folds, so this is harmless.
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99

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
