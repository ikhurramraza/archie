return {
  "AndrewRadev/sideways.vim",
  cmd = { "SidewaysLeft", "SidewaysRight" },
  keys = {
    {
      "<C-H>",
      vim.cmd.SidewaysLeft,
      silent = true,
      desc = "Move to the left using Sideways",
    },
    {
      "<C-L>",
      vim.cmd.SidewaysRight,
      silent = true,
      desc = "Move to the right using Sideways",
    },
  },
}
