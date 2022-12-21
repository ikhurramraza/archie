local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

treesitter.setup({
  ensure_installed = {
    "help",
    "javascript",
    "lua",
    "ruby",
    "rust",
    "typescript",
    "vim",
  },
  highlight = {
    enable = true,
  },
})
