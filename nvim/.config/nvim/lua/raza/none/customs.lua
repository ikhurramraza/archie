local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local utils = require("raza.none.utils")
local paths = require("raza.paths")

-- Diagnostics

local rubocop_diagnostics = null_ls.builtins.diagnostics.rubocop.with({
  command = "rubocop",
  dynamic_command = utils.bundle_prefixed_dynamic_command(),
})

-- Formatting

local sql_formatter = null_ls.builtins.formatting.sql_formatter.with({
  args = { "--config", paths.for_fixture("sql-formatter.json") },
})

local syntax_tree = {
  name = "syntax_tree",
  method = null_ls.methods.FORMATTING,
  filetypes = { "ruby" },
  generator = helpers.formatter_factory({
    command = "stree",
    dynamic_command = utils.bundle_prefixed_dynamic_command(),
    args = { "format" },
    to_stdin = true,
  }),
}

return {
  diagnostics = {
    rubocop = rubocop_diagnostics,
  },
  formatting = {
    sql_formatter = sql_formatter,
    syntax_tree = syntax_tree,
  },
}
