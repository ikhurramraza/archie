local main = require("skeleton.main")
local config = require("skeleton.config")

local M = {
  setup = config.setup,
  open = main.open,
  settings = config.settings,
}

return M
