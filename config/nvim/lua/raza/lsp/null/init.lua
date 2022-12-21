local null_ls = require("null-ls")
local customs = require("raza.lsp.null.customs")

local null_config_path = vim.env.XDG_CONFIG_HOME .. "/null/"

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.trail_space,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.sql_formatter.with({
      extra_args = { "--config", null_config_path .. "sql-formatter.json" },
    }),
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.shfmt.with({
      extra_args = { "-i=2" },
      extra_filetypes = { "zsh" },
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace,

    customs.diagnostics.bundled_rubocop,
    customs.formatting.stree,
  },

  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ timeout_ms = 5000 })
  end, { silent = true }),
})
