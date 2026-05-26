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

    -- Built-in LSP completion (Neovim 0.11+); no completion plugin needed.
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/completion') then
          vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
        end
      end,
    })
  end,
}
