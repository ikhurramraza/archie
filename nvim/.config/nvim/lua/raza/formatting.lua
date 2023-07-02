local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

-- Ruby bundle prefixed dynamic commands
-- For Ruby apps managed by bundler, we need to use bundle exec command
-- instead of simply using the command. Hence, we need to set the command
-- dynamically and it needs to be cached to avoid directory exists calls
-- on the subsequent runs for better performance.

local function bundle_prefixed_dynamic_command()
  local cached_command = nil

  return function(params)
    if cached_command then
      return cached_command
    end

    local Path = require("plenary.path")
    local vendor_bundle_path = Path:new(params.root .. "/vendor/bundle")

    if vendor_bundle_path:is_dir() then
      cached_command = { "bundle", "exec", params.command }
    else
      cached_command = params.command
    end

    return cached_command
  end
end

-- Diagnostics

local bundled_rubocop_diagnostics = null_ls.builtins.diagnostics.rubocop.with({
  command = "rubocop",
  dynamic_command = bundle_prefixed_dynamic_command(),
  args = { "-fj", "--force-exclusion", "-s", "$FILENAME" },
})

-- Formatters

local stree_formatter = {
  name = "stree",
  method = null_ls.methods.FORMATTING,
  filetypes = { "ruby" },
  generator = helpers.formatter_factory({
    command = "stree",
    dynamic_command = bundle_prefixed_dynamic_command(),
    args = function(params)
      local bufnr = vim.fn.bufnr()
      local filename = string.sub(params.bufname, #params.root + 2)

      if vim.fn.getbufinfo(bufnr)[1].changed then
        vim.cmd.w()
      end

      return { "format", filename }
    end,
  }),
}

local bundled_rubocop_formatter = null_ls.builtins.formatting.rubocop.with({
  command = "rubocop",
  dynamic_command = bundle_prefixed_dynamic_command(),
  args = { "-fq", "-a", "--stderr", "-s", "$FILENAME" },
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
