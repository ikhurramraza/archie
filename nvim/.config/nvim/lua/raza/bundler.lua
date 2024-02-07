--- Cache for bundle_command function
--- @type string | nil
local bundle_command_prefix_cache = nil

--- Helper method that converts a command to a bundler command
--- based on the the presence of "vendor/bundle" directory in
--- the project root directory.
--- @param command string
--- @return string
local function bundle_command(command)
  if bundle_command_prefix_cache then
    return bundle_command_prefix_cache .. command
  end

  local Path = require("plenary.path")
  local vendor_bundle_path = Path:new(vim.fn.getcwd() .. "/vendor/bundle")

  if vendor_bundle_path:is_dir() then
    bundle_command_prefix_cache = "bundle exec "
  else
    bundle_command_prefix_cache = ""
  end

  return bundle_command(command)
end

return {
  bundle_command = bundle_command,
}
