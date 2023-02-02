local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<Space>', '')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map('n', '<leader>r', ':source $MYVIMRC<cr>')

-- Sensible pane navigation
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')

-- completion
map('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<Tab>']], { expr = true })
map('i', '<Tab>', [[pumvisible() ? '<C-n>' : '<Tab>']], { expr = true })
-- map('i', '<CR>', [[compe#confirm('<CR>')]], { expr = true })

map('n', '<leader>h', ':nohls<CR>')
map('n', '<leader>\\', ':vsp<CR>')
map('n', '<leader>-', ':sp<CR>')
map('n', '<leader>r', ':source ~/.config/nvim/init.lua<CR>')
map('n', '<leader>_', ':wincmd _<cr>:wincmd \\|<cr>')
map('n', '<leader>=', ':wincmd =<cr>')

-- telescope
map("n", "<leader>ff", [[<cmd>lua require"telescope.builtin".find_files({hidden=true})<CR>]])
map("n", "<leader>lg", [[<cmd>lua require"telescope.builtin".live_grep()<CR>]])
map("n", "<leader>fb", [[<cmd>lua require"telescope.builtin".file_browser()<CR>]])
map("n", "<leader>mc", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])
map("n", "<leader>p", [[<cmd>Telescope neoclip<CR>]])

-- LSP
map('n', 'gD', [[<cmd>lua vim.lsp.buf.definition()<CR>]])
map('n', 'K', [[<cmd>Lspsaga hover_doc<CR>]])
map('v', 'K', [[<cmd>Lspsaga hover_doc<CR>]])
map('n', '<leader>sh', [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map('n', 'gi', [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map('n', 'gr', [[<cmd>lua vim.lsp.buf.references()<CR>]])
map('n', 'gh', [[<cmd>Lspsaga lsp_finder<CR>]])
map('n', 'gds', [[<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>]])
map('n', 'gws', [[<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<CR>]])
map('n', '<leader>rn', [[<cmd>Lspsaga rename<CR>]])
map('n', '<leader>ca', [[<cmd>Lspsaga code_action<CR>]])
map('n', '<leader>cd', [[<cmd>Lspsaga peek_definition<CR>]])
map('n', '<leader>ws', [[<cmd>lua require'metals'.hover_worksheet()<CR>]])
map('n', '<leader>a', [[<cmd>lua RELOAD('metals').open_all_diagnostics()<CR>]])
map('n', '<leader>tt', [[<cmd>lua require('metals.tvp').toggle_tree_view()<CR>]])
map('n', '<leader>tr', [[<cmd>lua require('metals.tvp').reveal_in_tree()<CR>]])
map('n', '<leader>d', [[<cmd>lua vim.diagnostic.setloclist()<CR>]]) -- buffer diagnostics only
-- map('n', '<leader>nd', [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
-- map('n', '<leader>pd', [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])
map('n', '<leader>sd', [[<cmd>Lspsaga show_line_diagnostics<CR>]])
map('n', '<leader>ft', [[<cmd>lua vim.lsp.buf.formatting()<CR>]])
map('n', ']e', [[<cmd>Lspsaga diagnostic_jump_next<CR>]])
map('n', '[e', [[<cmd>Lspsaga diagnostic_jump_prev<CR>]])
-- map('n', ']E', function() require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
-- map('n', '[E', function() require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)

map('n', '<leader>cl', [[<cmd>lua vim.lsp.codelens.run()<CR>]])
map('n', '<leader>st', [[<cmd>lua require('metals').toggle_setting('showImplicitArguments')<CR>]])

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
map('n', '<leader>44', '0y/))\\n<CR><C-w>npdf(:%s/\\n//g<CR>:%s/\\v, ?\\(/, (/g<CR>:s/, /\\r/g<CR>gg:%s/\\v\\) did.*t\\(/\\r\\r/<CR>ggvip:sort<CR>vip:Linediff<CR>Gvip:sort<CR>vip:Linediff<CR>')
map('n', '<leader>df', 'kJ[[<cmd>%s/\n//<CR>]][[<cmd>s/did/\r\r/<CR>]]df(gg0df([[<cmd>%s/, /\r/g<CR>]][[<cmd>%s/).*//<CR>]]ggvip[[<cmd>sort<CR>]]vip[[<cmd>Linediff<CR>]]Gvip[[<cmd>sort<CR>]]vip[[<cmd>Linediff<CR>]]')

-- nvim-tree
map('n', '<leader>e', ':NvimTreeToggle<CR>')
