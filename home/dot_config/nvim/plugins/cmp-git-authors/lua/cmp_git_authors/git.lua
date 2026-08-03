local M = {}

local cache = {}

M.authors = function()
  if cache.authors then
    return cache.authors
  end

  local handle = io.popen("git shortlog --summary --email --numbered")

  if handle == nil then
    cache.authors = {}
    return {}
  end

  local result = handle:read("*a")
  handle:close()

  local authors = {}
  for author in string.gmatch(result, "([^\n]+)") do
    local commits_count, name, email = string.match(author, "([%d]+)%s+(.+)%s+<(.+)>")

    if name ~= nil and email ~= nil then
      table.insert(authors, { author = name, email = email, commits_count = commits_count })
    end
  end

  cache.authors = authors
  return authors
end

return M
