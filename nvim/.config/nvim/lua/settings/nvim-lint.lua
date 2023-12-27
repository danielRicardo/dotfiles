-- https://github.com/mfussenegger/nvim-lint

local status_ok, lint = pcall(require, "lint")
if not status_ok then
  vim.notify("Unable to load nvim-lint. Liniting will be disables", "warn")
  return
end

local M = {}

M.setup = function()

  lint.linters_by_ft = {
    clojure = {"clj-kondo"},
    sh = {"shellcheck"}
  }

end

return M

