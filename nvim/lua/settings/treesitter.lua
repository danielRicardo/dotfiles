-- https://github.com/nvim-treesitter/nvim-treesitter

local M = {}

M.setup = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {'bash', 'clojure', 'css', 'dockerfile', 'html', 'java', 'javascript', 'json', 'lua', 'markdown', 'python', 'scala', 'yaml'},
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_line = nil
    },
    autopais = { enable = true },
  })

end

return M
