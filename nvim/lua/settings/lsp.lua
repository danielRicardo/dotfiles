local M = {}

M.setup = function()
	local lsp_installer = require('nvim-lsp-installer')

  local servers = {
    "yamlls",
    "sumneko_lua",
    "clojure_lsp",
    "dockerls"
  }

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found then
      if not server:is_installed() then
        print("Installing " .. name)
        server:install()
      end
    end
  end

  lsp_installer.on_server_ready(function(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local opts = {capabilities = capabilities}

    local enhance_server_opts = {
      ["yamlls"] = function(options)
        options.settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              -- ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/**/docker-compose*.y?(a)ml"
            }
          }
        }
      end,
      ["sumneko_lua"] = function(options)
        options.settings = {
          Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim', 'use'}},
            workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false},
            telemetry = {enable = false}
          }
        }
      end,
    }

    if enhance_server_opts[server.name] then
      enhance_server_opts[server.name](opts)
    end

    server:setup(opts)
  end)
end

return M
