local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

-- Diagnostics

local bundled_rubocop_diagnostics = null_ls.builtins.diagnostics.rubocop.with({
  command = "bundle",
  args = { "exec", "rubocop", "-fj", "--force-exclusion", "-s", "$FILENAME" },
})

-- Formatters

local stree_formatter = {
  name = "stree",
  method = null_ls.methods.FORMATTING,
  filetypes = { "ruby" },
  generator = helpers.formatter_factory({
    command = "bundle",
    args = { "exec", "stree", "format" },
    to_stdin = true,
  }),
}

local bundled_rubocop_formatter = null_ls.builtins.formatting.rubocop.with({
  command = "bundle",
  args = { "exec", "rubocop", "-fq", "-a", "--stderr", "-s", "$FILENAME" },
})

return {
  diagnostics = {
    bundled_rubocop = bundled_rubocop_diagnostics,
  },
  formatting = {
    bundled_rubocop = bundled_rubocop_formatter,
    stree = stree_formatter,
  },
}
