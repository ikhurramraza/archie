return {
  "laytan/cloak.nvim",
  event = { "BufReadPre *.env*", "BufNewFile *.env*" },
  opts = {
    patterns = {
      { file_pattern = "*.env*", cloak_pattern = "=.+" },
    },
  },
}
