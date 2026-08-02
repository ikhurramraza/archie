return {
  "laytan/cloak.nvim",
  event = { "BufReadPre *.env*", "BufNewFile *.env*" },
  opts = {
    cloak_length = 16,
    patterns = {
      { file_pattern = "*.env*", cloak_pattern = "=.+" },
    },
  },
}
