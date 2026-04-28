return {
  "scalameta/nvim-metals",
  opts = function(_, opts)
    opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
      startMcpServer = true,
    })
    return opts
  end,
}
