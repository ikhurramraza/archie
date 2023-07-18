local function build_key(key, mode, refactor)
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
  "ThePrimeagen/refactoring.nvim",
  keys = {
    build_key("<leader>rB", "n", "Extract Block To File"),
    build_key("<leader>rF", "x", "Extract Function To File"),
    build_key("<leader>rb", "n", "Extract Block"),
    build_key("<leader>rf", "x", "Extract Function"),
    build_key("<leader>ri", "n", "Inline Variable"),
    build_key("<leader>ri", "x", "Inline Variable"),
    build_key("<leader>rv", "x", "Extract Variable"),
  },
}
