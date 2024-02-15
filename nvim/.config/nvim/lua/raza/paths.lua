local M = {}

M.env = {
  append = function(path)
    local current_path = vim.fn.getenv("PATH")
    local new_path = current_path .. ":" .. path
    vim.fn.setenv("PATH", new_path)
  end,
  prepend = function(path)
    local current_path = vim.fn.getenv("PATH")
    local new_path = path .. ":" .. current_path
    vim.fn.setenv("PATH", new_path)
  end,
}

return M
