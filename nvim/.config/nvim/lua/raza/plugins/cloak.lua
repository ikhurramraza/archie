return {
  "laytan/cloak.nvim",
  ft = "sh",
  opts = {
    patterns = {
      { file_pattern = "*.env", cloak_pattern =  "=.+" },
    },
  },
}
