-- https://github.com/nvim-treesitter/nvim-treesitter

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("Unable to load Treesitter. Syntax highlighting will be limited", "warn")
  return
end

local M = {}

M.setup = function()
  configs.setup({
    ensure_installed = {
      'bash',
      'clojure',
      'css',
      'dockerfile',
      'help',
      'html',
      'java',
      'javascript',
      'json',
      'jsonc',
      'lua',
      'markdown',
      'python',
      'scala',
      'yaml'
    },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_line = nil
    },
    autopairs = { enable = true },
    refactor = {
      highlight_current_scope = { enable = true },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "<leader>rn",
        },
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<localleader>)",
          goto_previous_usage = "<localleader>(",
        },
      },
    }
  })

end

return M
