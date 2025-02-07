return {
  "nvimtools/none-ls.nvim",
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
        builtins.formatting.shfmt.with({
          extra_filetypes = { "bash" },
          extra_args = { "--indent", "2" },
        }),
        builtins.formatting.stylua,
        builtins.hover.dictionary,
        customs.formatting.sql_formatter,
        customs.formatting.syntax_tree,
      },
    }
  end,
}
