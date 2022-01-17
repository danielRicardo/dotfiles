-- https://github.com/kyazdani42/nvim-tree.lua

local M = {}

M.setup = function ()
  require'nvim-tree'.setup {
    auto_close          = true,
    diagnostics = {
      enable = true,
    },
  }
end

return M
