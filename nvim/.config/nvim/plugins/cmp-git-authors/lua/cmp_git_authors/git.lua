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

    if name == nil or email == nil then
      goto continue
    end

    table.insert(authors, { author = name, email = email, commits_count = commits_count })

    ::continue::
  end

  cache.authors = authors
  return authors
end

return M
