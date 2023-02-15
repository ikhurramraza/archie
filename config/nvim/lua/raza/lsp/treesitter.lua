local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

treesitter.setup({
  ensure_installed = {
    "bash",
    "help",
    "html",
    "ini",
    "javascript",
    "json",
    "lua",
    "make",
    "ruby",
    "rust",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
  },
})
