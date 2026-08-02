local paths = require("raza.paths")

return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  event = { "BufWritePre" },
  keys = {
    {
      "<leader>xf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format using conform",
    },
  },
  opts = {
    formatters = {
      sql_formatter = { prepend_args = { "--config", paths.for_fixture("sql-formatter.json") } },
      zsh = { prepend_args = { "--indent", "2" } },
    },
    formatters_by_ft = {
      bash = { "shfmt" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      lua = { "stylua" },
      ruby = { "syntax_tree" },
      sql = { "sql_formatter" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      zsh = { "shfmt" },
    },
  },
}
