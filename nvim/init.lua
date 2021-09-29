local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local f = require('settings.functions')
local map = f.map
local opt = vim.opt
local global_opt = vim.opt_global

cmd([[packadd packer.nvim]])
require('plugins')
require('settings.functions')
require('settings.telescope').setup()
require('settings.compe').setup()
require('settings.lsp').setup()

----------------------------------
-- OPTIONS -----------------------
----------------------------------
local indent = 2

-- global
global_opt.shortmess:remove('F'):append('c')
global_opt.termguicolors = true
global_opt.hidden = true
global_opt.showtabline = 1
global_opt.updatetime = 300
global_opt.showmatch = true
global_opt.laststatus = 2
global_opt.wildignore = { '.git', '*/node_modules/*', '*/target/*', '.metals', '.bloop', '.ammonite' }
global_opt.ignorecase = true
global_opt.smartcase = true
global_opt.clipboard = 'unnamed'
global_opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }

-- window-scoped
opt.wrap = false
opt.cursorline = true
opt.signcolumn = 'yes'
opt.number = true
opt.relativenumber = true
opt.shiftwidth = 2
opt.softtabstop = 2


-- buffer-scoped
opt.tabstop = indent
opt.expandtab = true
opt.fileformat = 'unix'

-- Look and Feel
if fn.exists('&termguicolors') then
  opt.termguicolors = true
  opt.background = 'dark'
  g.neosolarized_termtrans=1
  cmd('colorscheme NeoSolarized')
end

-- Remappings
map('n', '<Space>', '')
g.mapleader = ' '

map('n', '<leader>r', ':source $MYVIMRC<cr>')

-- Sensible pane navigation
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')

-- completion
map('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<Tab>']], { expr = true })
map('i', '<Tab>', [[pumvisible() ? '<C-n>' : '<Tab>']], { expr = true })
map('i', '<CR>', [[compe#confirm('<CR>')]], { expr = true })

map('n', '<leader>h', ':nohls<CR>')
map('n', '<leader>\\', ':vsp<CR>')
map('n', '<leader>-', ':sp<CR>')
map('n', '<leader>r', ':source ~/.config/nvim/init.lua<CR>')
map('n', '<leader>_', ':wincmd _<cr>:wincmd \\|<cr>')
map('n', '<leader>=', ':wincmd =<cr>')

-- LSP
map('n', 'gD', [[<cmd>lua vim.lsp.buf.definition()<CR>]])
map('n', 'K', [[<cmd>lua vim.lsp.buf.hover()<CR>]])
map('v', 'K', [[<cmd>lua vim.lsp.buf.hover()<CR>]])
map('n', '<leader>sh', [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map('n', 'gi', [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map('n', 'gr', [[<cmd>lua vim.lsp.buf.references()<CR>]])
map('n', 'gds', [[<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>]])
map('n', 'gws', [[<cmd>lua require'settings.telescope'.lsp_workspace_symbols()<CR>]])
map('n', '<leader>rn', [[<cmd>lua vim.lsp.buf.rename()<CR>]])
map('n', '<leader>ca', [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
map('n', '<leader>ws', [[<cmd>lua require'metals'.hover_worksheet()<CR>]])
map('n', '<leader>a', [[<cmd>lua RELOAD('metals').open_all_diagnostics()<CR>]])
map('n', '<leader>tt', [[<cmd>lua require('metals.tvp').toggle_tree_view()<CR>]])
map('n', '<leader>tr', [[<cmd>lua require('metals.tvp').reveal_in_tree()<CR>]])
map('n', '<leader>d', [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]]) -- buffer diagnostics only
map('n', '<leader>nd', [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]])
map('n', '<leader>pd', [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]])
map('n', '<leader>ld', [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]])

map('n', '<leader>cl', [[<cmd>lua vim.lsp.codelens.run()<CR>]])
map('n', '<leader>st', [[<cmd>lua require('metals').toggle_setting('showImplicitArguments')<CR>]])

-- completion
map('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<Tab>']], { expr = true })
map('i', '<Tab>', [[pumvisible() ? '<C-n>' : '<Tab>']], { expr = true })
map('i', '<CR>', [[compe#confirm('<CR>')]], { expr = true })

-- telescope
map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
map('n', '<leader>lg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').file_browser()<CR>]])
map('n', '<leader>mc', [[<cmd>lua require('telescope').extensions.metals.commands()<CR>]])


cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])

