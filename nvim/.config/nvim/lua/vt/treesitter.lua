local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then return end

treesitter.setup({
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = { enable = true, },
  autotag = { enable = true, },
  ensure_installed = { "bash", "c", "java", "python", "latex", "html", "json", "lua" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  auto_install = true
})
