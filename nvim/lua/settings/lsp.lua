local M = {}

M.setup = function()
	local lsp_installer = require('nvim-lsp-installer')

	lsp_installer.on_server_ready(function(server)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local opts = {capabilities = capabilities}

		if server.name == "yamlls" then
      opts = vim.tbl_deep_extend("force", {
			settings = {
        yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "**/docker-compose*.y?(a)ml"
            }
          }
			}
      }, opts)
    end

    if server.name == "sumneko_lua" then
      opts = vim.tbl_deep_extend("force", {
        settings = {
          Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim'}},
            workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false},
            telemetry = {enable = false}
          }
        }

      }, opts)
    end

    server:setup(opts)
  end)
end

return M
