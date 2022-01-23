local cmd = vim.cmd

require('plugins')
require('settings.functions')
require('settings.options')
require('settings.colorscheme')
require('settings.remaps')


cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])

