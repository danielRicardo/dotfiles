local colorscheme = 'github-theme'

local status_ok, github_theme = pcall(require, colorscheme)
if not status_ok then
  vim.notify("Colrscheme " .. colorscheme .. " not found. Using default colorscheme", "warn")
  return
end

github_theme.setup({
  theme_style = 'dimmed'
})
