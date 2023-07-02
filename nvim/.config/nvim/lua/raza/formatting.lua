local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

-- Ruby bundle prefixed dynamic commands
-- For Ruby apps managed by bundler, we need to use bundle exec command
-- instead of simply using the command. Hence, we need to set the command
-- dynamically and it needs to be cached to avoid directory exists calls
-- on the subsequent runs for better performance.

local bundle_prefix_cache = {}

local function bundle_prefixed_dynamic_command(command, cache_key)
  return function(params)
    if bundle_prefix_cache[cache_key] then
      return bundle_prefix_cache[cache_key]
    end

    local Path = require("plenary.path")
    local vendor_bundle_path = Path:new(params.root .. "/vendor/bundle")

    if vendor_bundle_path:is_dir() then
      bundle_prefix_cache[cache_key] = { "bundle", "exec", command }
    else
      bundle_prefix_cache[cache_key] = command
    end

    return bundle_prefix_cache[cache_key]
  end
end

-- Diagnostics

local bundled_rubocop_diagnostics = null_ls.builtins.diagnostics.rubocop.with({
  dynamic_command = bundle_prefixed_dynamic_command("rubocop", "bundled_rubocop_diagnostics"),
  args = { "-fj", "--force-exclusion", "-s", "$FILENAME" },
})

-- Formatters

local stree_formatter = {
  name = "stree",
  method = null_ls.methods.FORMATTING,
  filetypes = { "ruby" },
  generator = helpers.formatter_factory({
    dynamic_command = bundle_prefixed_dynamic_command("stree", "stree_formatter"),
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
  dynamic_command = bundle_prefixed_dynamic_command("rubocop", "bundled_rubocop_formatter"),
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
