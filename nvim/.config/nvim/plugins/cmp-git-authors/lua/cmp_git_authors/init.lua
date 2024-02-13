local git = require("cmp_git_authors.git")

local M = {}

TRIGGER_CHARACTER = "@"

M.new = function()
  return setmetatable({}, { __index = M })
end

M.get_trigger_characters = function()
  return { TRIGGER_CHARACTER }
end

M.complete = function(_, params, callback)
  local input = string.sub(params.context.cursor_before_line, params.offset - 1)
  local prefix = string.sub(params.context.cursor_before_line, 1, params.offset - 1)

  if not vim.endswith(prefix, " " .. TRIGGER_CHARACTER) then
    callback({ isIncomplete = true })
    return
  end

  local items = {}

  for _, author in ipairs(git.authors()) do
    local name_and_email = author.author .. " <" .. author.email .. ">"

    table.insert(items, {
      label = name_and_email,
      insertText = name_and_email,
      filterText = TRIGGER_CHARACTER .. name_and_email,
      textEdit = {
        newText = name_and_email,
        range = {
          ["start"] = {
            line = params.context.cursor.row - 1,
            character = params.context.cursor.col - 1 - #input,
          },
          ["end"] = {
            line = params.context.cursor.row - 1,
            character = params.context.cursor.col - 1,
          },
        },
      },
    })
  end

  callback({ items = items, isIncomplete = true })
end

return M
