-- https://github.com/nvim-telescope/telescope.nvim

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("Unable to load telescope", "warn")
  return
end

local M = {}

M.setup = function()
  local actions = require("telescope.actions")
  telescope.setup({
    defaults = {
      file_ignore_patterns = { "target", "node_modules", "parser.c", "out", ".git" },
      prompt_prefix = "❯",
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      mappings = {
        n = {
          ["f"] = actions.send_to_qflist,
        },
      },
    },
  })

  telescope.load_extension("fzy_native")
end

-- This is mainly for Metals since we don't respond to "" as a query to get all
-- the symbols. This will first get the input form the user and then execute
-- the query.
M.lsp_workspace_symbols = function()
  local input = vim.fn.input("Query: ")
  vim.api.nvim_command("normal :esc<CR>")
  if not input or #input == 0 then
    return
  end
  require("telescope.builtin").lsp_workspace_symbols({ query = input })
end

return M
