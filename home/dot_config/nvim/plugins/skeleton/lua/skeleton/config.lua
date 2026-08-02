local M = {}

local defaults = {
  directories = {
    vim.fn.stdpath("config") .. "/skeletons",
    vim.fn.stdpath("data") .. "/skeletons",
  },
}

M.setup = function(opts)
  M.settings = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
