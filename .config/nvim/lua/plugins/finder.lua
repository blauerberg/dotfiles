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
    -- Code navigation: follow definitions, callers, and the call graph while
    -- reading. Each query is answered by the LSP server and shown with preview.
    { '<leader>cd', function() require('fzf-lua').lsp_definitions() end, desc = 'Go to definition' },
    { '<leader>cr', function() require('fzf-lua').lsp_references() end, desc = 'References' },
    { '<leader>ct', function() require('fzf-lua').lsp_typedefs() end, desc = 'Type definition' },
    { '<leader>ci', function() require('fzf-lua').lsp_incoming_calls() end, desc = 'Incoming calls (callers)' },
    { '<leader>co', function() require('fzf-lua').lsp_outgoing_calls() end, desc = 'Outgoing calls (callees)' },
  },
  opts = {},
}
