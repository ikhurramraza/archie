local config = require("skeleton.config")

local M = {}

local function prettify_skeleton_path(old_path)
  local new_path = old_path

  for _, directory in ipairs(config.settings.directories) do
    new_path = vim.fn.substitute(new_path, directory .. "/", "", "")
  end

  return new_path
end

local function get_skeletons()
  local skeletons = {}

  for _, directory in ipairs(config.settings.directories) do
    local files = vim.fn.glob(directory .. "/*/*")
    for _, skeleton in ipairs(vim.split(files, "\n")) do
      if skeleton ~= "" then
        table.insert(skeletons, skeleton)
      end
    end
  end

  return skeletons
end

M.open = function()
  local skeletons = get_skeletons()

  if #skeletons == 0 then
    vim.api.nvim_echo({ { "No skeletons found.", "ErrorMsg" } }, true, {})
    return
  end

  vim.ui.select(skeletons, {
    prompt = "Select a skeleton:",
    format_item = prettify_skeleton_path,
  }, function(choice)
    if choice then
      local skeleton = vim.fn.readfile(choice)
      vim.api.nvim_put(skeleton, "l", false, false)
    end
  end)
end

return M
