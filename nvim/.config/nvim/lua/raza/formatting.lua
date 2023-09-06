local null_ls = require("null-ls")

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

-- Code actions

local node_moduled_eslint_code_action = null_ls.builtins.code_actions.eslint.with({
  command = "node_modules/.bin/eslint",
})

-- Diagnostics

local bundled_rubocop_diagnostics = null_ls.builtins.diagnostics.rubocop.with({
  command = "rubocop",
  dynamic_command = bundle_prefixed_dynamic_command(),
  args = { "-fj", "--force-exclusion", "-s", "$FILENAME" },
})

local node_moduled_eslint_diagnostics = null_ls.builtins.diagnostics.eslint.with({
  command = "node_modules/.bin/eslint",
})

return {
  code_actions = {
    node_moduled_eslint = node_moduled_eslint_code_action,
  },
  diagnostics = {
    bundled_rubocop = bundled_rubocop_diagnostics,
    node_moduled_eslint = node_moduled_eslint_diagnostics,
  },
}
