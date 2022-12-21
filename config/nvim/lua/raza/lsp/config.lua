local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  -- Disable formating by the language server (using null-ls for this)
  client.server_capabilities.documentFormattingProvider = false

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
end

lsp.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- See: https://github.com/sumneko/lua-language-server/wiki/Settings
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      completion = { keywordSnippet = "Disable" },
    },
  },
})

require("rust-tools").setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
})

require("typescript").setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
})
