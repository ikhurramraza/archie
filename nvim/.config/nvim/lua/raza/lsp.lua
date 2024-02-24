local M = {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = function(client, bufnr)
    -- Disable formating by the language server (using other tools/plugins for this)
    client.server_capabilities.documentFormattingProvider = false

    -- Disable syntax highlighting from LSP
    client.server_capabilities.semanticTokensProvider = nil

    local set = function(key, callback, opts)
      vim.keymap.set(
        "n",
        key,
        callback,
        vim.tbl_deep_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts)
      )
    end

    set("gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    set("gr", vim.lsp.buf.references, { desc = "Go to references" })
    set("gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    set("gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    set("K", vim.lsp.buf.hover, { desc = "Show hover information" })
    set("<leader>K", vim.lsp.buf.signature_help, { desc = "Get signature help" })
    set("<leader>gd", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
    set("<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })

    set("<leader>oh", function()
      vim.lsp.inlay_hint(bufnr, nil)
    end, { desc = "Toggle inlay hints" })
  end,
}

return M
