-- https://github.com/kyazdani42/nvim-tree.lua

local status_ok, tree = pcall(require, "nvim-tree")

if not status_ok then
  vim.notify("Unable to load nvim-tree", "warn")
  return
end

local M = {}

M.setup = function ()
  tree.setup {
    auto_close = true,
    hijack_cursor = true,
    open_on_setup = true,
    update_cwd = true,
    diagnostics = {
      enable = true,
    },
    view = {
      width = 30,
      auto_resize = true,
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    filters = {
      dotfiles = false,
      custom = { '.git' },
    },
  }

end

return M
