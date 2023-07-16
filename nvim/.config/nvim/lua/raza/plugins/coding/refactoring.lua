local function key(key, mode, refactor)
  return {
    key,
    function()
      require("refactoring").refactor(refactor)
    end,
    silent = true,
    mode = mode,
    desc = "Refactor: " .. refactor,
  }
end

return {
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      key("<leader>rB", "n", "Extract Block To File"),
      key("<leader>rF", "x", "Extract Function To File"),
      key("<leader>rb", "n", "Extract Block"),
      key("<leader>rf", "x", "Extract Function"),
      key("<leader>ri", "n", "Inline Variable"),
      key("<leader>ri", "x", "Inline Variable"),
      key("<leader>rv", "x", "Extract Variable"),
    },
  },
}
