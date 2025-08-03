return {
  "dmtrKovalenko/fff.nvim",
  build = "cargo build --release",
  opts = {},
  keys = {
    {
      "<leader>ff",
      function()
        require("fff").find_files()
      end,
      desc = "[F]ind [F]iles",
    },
  },
}
