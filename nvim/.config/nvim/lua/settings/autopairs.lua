-- https://github.com/windwp/nvim-autopairs

local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
  vim.notify("Unable to load autopairs", "warn")
  print("Error mesage: ", autopairs)
  return
end

local M = {}

M.setup = function()
  autopairs.setup({check_ts = true})
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

  -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
  -- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "clojure"

end

return M
