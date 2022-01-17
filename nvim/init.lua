local cmd = vim.cmd
local g = vim.g
local f = require('settings.functions')
local map = f.map
local opt = vim.opt
local global_opt = vim.opt_global

----------------------------------
-- BOOTSTRAP PACKER --------------
----------------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

----------------------------------
-- PLUGINS -----------------------
----------------------------------

cmd([[packadd packer.nvim]])
require('plugins')
require('settings.functions')
require('settings.telescope').setup()
require('settings.cmp').setup()
require('settings.lsp').setup()
require('settings.metals').setup()
require('settings.dap').setup()
require('settings.vim-test')
require('settings.lualine').setup()
require('settings.signify').setup()
require('settings.treesitter').setup()
require('settings.autopairs').setup()


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
end
require('github-theme').setup({
  theme_style = "dimmed",
})

-- Remappings
map('n', '<Space>', '')
g.mapleader = ' '
g.maplocalleader = ','

map('n', '<leader>r', ':source $MYVIMRC<cr>')

-- Sensible pane navigation
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')

-- completion
map('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<Tab>']], { expr = true })
map('i', '<Tab>', [[pumvisible() ? '<C-n>' : '<Tab>']], { expr = true })

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
map('n', '<leader>ft', [[<cmd>lua vim.lsp.buf.formatting()<CR>]])

map('n', '<leader>cl', [[<cmd>lua vim.lsp.codelens.run()<CR>]])
map('n', '<leader>st', [[<cmd>lua require('metals').toggle_setting('showImplicitArguments')<CR>]])

-- telescope
map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
map('n', '<leader>lg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').file_browser()<CR>]])
map('n', '<leader>mc', [[<cmd>lua require('telescope').extensions.metals.commands()<CR>]])

-- nvim-dap
map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n", "<leader>ds", [[<cmd>lua require"dap.ui.variables".scopes()<CR>]])
map("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
map("n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
map("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])

-- scala-utils
map("n", "<leader>slc", [[<cmd>lua RELOAD("scala-utils.coursier").complete_from_line()<CR>]])
map("n", "<leader>sc", [[<cmd>lua RELOAD("scala-utils.coursier").complete_from_input()<CR>]])

-- vim-test
map('n', '<leader>tn', ':TestNearest<CR>')
map('n', '<leader>tf', ':TestFile<CR>')
map('n', '<leader>ts', ':TestSuite<CR>')
map('n', '<leader>tl', ':TestLast<CR>')
map('n', '<leader>tv', ':TestVisit<CR>')
map('t', '<C-o>', '<C-\\><C-n>')
map('n', '<leader>df', '0y/))\\n<CR><C-w>npdf(:%s/\\n//g<CR>:%s/\\v, ?\\(/, (/g<CR>:s/, /\\r/g<CR>gg:%s/\\v\\) did.*t\\(/\\r\\r/<CR>ggvip:sort<CR>vip:Linediff<CR>Gvip:sort<CR>vip:Linediff<CR>')


cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])

