-- https://github.com/kyazdani42/nvim-tree.lua

local status_ok, tree = pcall(require, "nvim-tree")

if not status_ok then
  vim.notify("Unable to load nvim-tree", "warn")
  return
end

local M = {}

M.setup = function ()
  tree.setup {
    hijack_cursor = true,
    open_on_setup = true,
    update_cwd = true,
    diagnostics = {
      enable = true,
    },
    view = {
      width = 30,
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    filters = {
      dotfiles = false,
      custom = { '.git' },
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
  }

end

return M
