-- https://github.com/kyazdani42/nvim-tree.lua

local status_ok, tree = pcall(require, "nvim-tree")

if not status_ok then
  vim.notify("Unable to load nvim-tree", "warn")
  return
end

local M = {}

M.setup = function ()
  tree.setup {
    auto_close = hide,
    hijack_cursor = true,
    diagnostics = {
      enable = true,
    },
    view = {
      width = '20%',
      auto_resize = true,
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
  }

end

return M
