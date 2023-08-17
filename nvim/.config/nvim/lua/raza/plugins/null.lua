local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = "neovim/nvim-lspconfig",
  keys = {
    {
      "<leader><leader>",
      function()
        vim.lsp.buf.format({ timeout_ms = 5000 })
      end,
      silent = true,
      desc = "Format the document",
    },
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      silent = true,
      desc = "Open code actions menu",
    },
  },
}

function M.config()
  local null_ls = require("null-ls")
  local customs = require("raza.formatting")
  local config_path = vim.env.XDG_CONFIG_HOME .. "/null/"

  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.trail_space.with({
        disabled_filetypes = { "gitcommit" },
      }),
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.sql_formatter.with({
        extra_args = { "--config", config_path .. "sql-formatter.json" },
      }),
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i=2" },
        extra_filetypes = { "zsh" },
      }),
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,

      customs.code_actions.node_moduled_eslint,
      customs.diagnostics.bundled_rubocop,
      customs.diagnostics.node_moduled_eslint,
      customs.formatting.stree,
    },
  })
end

return M
