-- https://github.com/rcarriga/nvim-notify
--

local M = {}

M.setup = function ()
  if vim.fn.exists('&termguicolors') then
    vim.opt.termguicolors = true
  end

  require("notify").setup({
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
  })
  vim.notify = require("notify")
end

return M
