-- https://github.com/kyazdani42/nvim-tree.lua

local M = {}

M.setup = function ()
  require'nvim-tree'.setup {
    auto_close = true,
    hijack_cursor = true,
    diagnostics = {
      enable = true,
    },
    view = {
      width = '15%',
      auto_resize = true,
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
  }

end

return M
