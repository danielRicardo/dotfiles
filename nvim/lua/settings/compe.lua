local M = {}

-- https://github.com/hrsh7th/nvim-compe
M.setup = function()
  require("compe").setup({
    enabled = true,
    debug = false,
    min_length = 1,

    source = {
      path = true,
      buffer = true,
      vsnip = {
        filetypes = { "scala", "html", "javascript", "lua", "java", "go" },
      },
      nvim_lsp = {
        priority = 1000,
        filetypes = { "scala", "html", "javascript", "lua", "java", "go" },
      },
      tags = true,
      snippets_nvim = true
    },
  })
end

return M
