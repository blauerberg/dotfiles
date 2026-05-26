return {
  'neovim/nvim-lspconfig',
  lazy = false,
  config = function()
    -- Server name (nvim-lspconfig) -> executable that must exist on PATH.
    local servers = {
      ts_ls = 'typescript-language-server',
      pyright = 'pyright-langserver',
      gopls = 'gopls',
      rust_analyzer = 'rust-analyzer',
      lua_ls = 'lua-language-server',
    }
    for name, bin in pairs(servers) do
      if vim.fn.executable(bin) == 1 then
        vim.lsp.enable(name)
      end
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        local buf = args.buf

        -- Built-in LSP completion (Neovim 0.11+); no completion plugin needed.
        if client:supports_method('textDocument/completion') then
          vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
        end

        -- Inlay hints: show inferred types and parameter names inline, which
        -- makes untyped-looking code readable. Toggle with <leader>ch when noisy.
        if client:supports_method('textDocument/inlayHint') then
          vim.lsp.inlay_hint.enable(true, { bufnr = buf })
          vim.keymap.set('n', '<leader>ch', function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
          end, { buffer = buf, desc = 'Toggle inlay hints' })
        end

        -- Reference highlight: after the cursor rests (updatetime=500ms), the
        -- server reports every use of the symbol under the cursor and we paint
        -- them, so a variable's usage in the buffer is visible at a glance.
        if client:supports_method('textDocument/documentHighlight') then
          local group = vim.api.nvim_create_augroup('lsp_doc_highlight_' .. buf, { clear = true })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = group, buffer = buf, callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = group, buffer = buf, callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
  end,
}
