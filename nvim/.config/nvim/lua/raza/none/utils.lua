local utils = {}

-- Ruby bundle prefixed dynamic commands
-- For Ruby apps managed by bundler, we need to use bundle exec command
-- instead of simply using the command. Hence, we need to set the command
-- dynamically and it needs to be cached to avoid directory exists calls
-- on the subsequent runs for better performance.
function utils.bundle_prefixed_dynamic_command()
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

return utils
