return {
  'nvim-treesitter/nvim-treesitter',
  -- The 'main' branch is a full rewrite for Neovim 0.12+; 'master' is locked.
  -- It does NOT support lazy-loading, so load eagerly. ':TSUpdate' keeps the
  -- installed parsers in sync with the versions this plugin expects.
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- On 'main' the plugin only installs parsers/queries; it no longer enables
    -- features for us. Install parsers (compiled once via the tree-sitter CLI),
    -- then wire highlighting/indent ourselves below.
    require('nvim-treesitter').install({
      'typescript', 'tsx', 'javascript', 'python',
      'lua', 'vim', 'vimdoc', 'json', 'yaml', 'bash', 'markdown', 'markdown_inline',
    })

    -- Highlighting is a core Neovim feature but is off by default; start it per
    -- buffer. vim.treesitter.start() derives the language from the filetype and
    -- errors when no parser is installed, so pcall skips unsupported filetypes.
    -- Treesitter indentation is provided by this plugin but experimental; enable
    -- it only where a parser actually loaded.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        if pcall(vim.treesitter.start) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
