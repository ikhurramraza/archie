return {
  "nvimtools/none-ls.nvim",
  commit = "b7cf202083b18bc9319e4c8ad5341a3d09241192",
  main = "null-ls",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },

  init = function()
    local paths = require("raza.paths")

    paths.env.prepend("node_modules/.bin")
    paths.env.append(vim.fn.stdpath("data") .. "/mason/bin")
  end,

  opts = function()
    local builtins = require("null-ls").builtins
    local customs = require("raza.none").customs

    return {
      sources = {
        builtins.diagnostics.zsh,
        builtins.formatting.prettier,
        builtins.formatting.shfmt,
        builtins.formatting.stylua,
        builtins.hover.dictionary,
        customs.diagnostics.rubocop,
        customs.formatting.sql_formatter,
        customs.formatting.syntax_tree,
      },
    }
  end,
}
