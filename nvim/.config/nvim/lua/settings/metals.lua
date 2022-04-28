-- https://github.com/scalameta/nvim-metals

local M = {}

M.setup = function()

  local shared_diagnostic_settings = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  Metals_config = require("metals").bare_config()

  Metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    excludedPackages = {
      "akka.actor.typed.javadsl",
      "com.github.swagger.akka.javadsl",
      "akka.stream.javadsl",
    },
    fallbackScalaVersion = "3.0.1",
    superMethodLensesEnabled = true,
  }

  Metals_config.init_options.statusBarProvider = "on"
  Metals_config.handlers["textDocument/publishDiagnostics"] = shared_diagnostic_settings
  Metals_config.capabilities = capabilities

  Metals_config.on_attach = function(client, bufnr)

    vim.api.nvim_create_autocmd("CursorHold <buffer>", {
      command = "lua vim.lsp.buf.document_highlight()"
    })

    vim.api.nvim_create_autocmd("CursorMoved <buffer>", {
      command = "lua vim.lsp.buf.clear_references()"
    })

    vim.api.nvim_create_autocmd("BufEnter,CursorHold,InsertLeave <buffer>", {
      command = "lua vim.lsp.codelens.refresh()"
    })

    require("metals").setup_dap()
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala" },
    command = "setlocal omnifunc=v:lua.vim.lsp.omnifunc"
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    command = "lua require('metals').initialize_or_attach(Metals_config)"
  })

end

return M
