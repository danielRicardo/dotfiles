local M = {}

M.setup = function()
  local mason = require('mason')
  local mason_lspconfig = require('mason-lspconfig')
  local saga = require('lspsaga')
  local lspconfig = require('lspconfig')
  local null_ls = require("null-ls")

  mason.setup()
  mason_lspconfig.setup()

  saga.setup({
    ui = {
      border = 'double',
    },
    finder_request_timeout = 3000,
  })

  local language_server_configs = {
    clojure_lsp = {},
    terraformls = {
      filetypes = { "terraform", "terraform-vars",  },
    },
    pyright = {},
    sumneko_lua = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }

  for server, config in pairs(language_server_configs) do
    lspconfig[server].setup {
      -- on_attach = on_attach,
      -- flags = lsp_flags,
      settings = config
    }
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.tf", "*.tfvars", "*.scala"},
    command = 'lua vim.lsp.buf.format()',
  })


  null_ls.setup({
    sources = {
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.clj_kondo,
      null_ls.builtins.diagnostics.jsonlint,
      null_ls.builtins.formatting.scalafmt,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.yamlfmt,
      null_ls.builtins.diagnostics.yamllint
    }
  })

end

return M
