return {
  "nvimtools/none-ls.nvim",
  main = "null-ls",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = {
    { "<leader>ca", vim.lsp.buf.code_action, silent = true, desc = "Open code actions menu" },
    { "<leader>xf", vim.lsp.buf.format, silent = true, desc = "Execute format" },
  },

  init = function()
    local paths = require("raza.paths")

    paths.env.prepend("node_modules/.bin")
    paths.env.append(vim.fn.stdpath("data") .. "/mason/bin")
  end,

  opts = function()
    local builtins = require("null-ls").builtins
    local customs = require("raza.none").customs

    local is_not_mac = function()
      return vim.loop.os_uname().sysname ~= "Darwin"
    end

    return {
      sources = {
        builtins.code_actions.eslint.with({ condition = is_not_mac }),
        builtins.diagnostics.eslint.with({ condition = is_not_mac }),
        builtins.diagnostics.zsh,
        builtins.formatting.prettier,
        builtins.formatting.rustfmt,
        builtins.formatting.shfmt,
        builtins.formatting.stylua,
        builtins.formatting.taplo,
        builtins.hover.dictionary,
        customs.diagnostics.rubocop,
        customs.formatting.sql_formatter,
        customs.formatting.syntax_tree,
      },
    }
  end,
}
