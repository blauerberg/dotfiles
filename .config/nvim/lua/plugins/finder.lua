return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  keys = {
    { '<leader>ff', function() require('fzf-lua').files() end, desc = 'Find files' },
    { '<leader>fg', function() require('fzf-lua').live_grep() end, desc = 'Live grep' },
    { '<leader>fb', function() require('fzf-lua').buffers() end, desc = 'Buffers' },
    { '<leader>fs', function() require('fzf-lua').lsp_document_symbols() end, desc = 'Document symbols' },
    { '<leader>fS', function() require('fzf-lua').lsp_live_workspace_symbols() end, desc = 'Workspace symbols' },
    { '<leader>fr', function() require('fzf-lua').resume() end, desc = 'Resume picker' },
  },
  opts = {},
}
