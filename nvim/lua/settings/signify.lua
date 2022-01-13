-- https://github.com/mhinz/vim-signify

local g = vim.g
local M = {}

M.setup = function()
  g.signify_sign_show_count = 0
  g.signify_sign_delete = '-'

end

return M
