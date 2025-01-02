-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- LSP and formatting
vim.keymap.set("n", "<leader>fd", vim.lsp.buf.format, { desc = "[F]ormat [D]ocument" })

vim.keymap.set(
	"n",
	"<leader>cu",
	":s/\\<\\u\\|\\l\\u/\\= join(split(tolower(submatch(0)), '\\zs'), '_')/g<CR>",
	{ desc = "[c]amelCase to snake[_]case" }
)

vim.keymap.set(
	"n",
	"<leader>uc",
	":s/\\(\\_[[:alnum:]]\\)\\(\\u\\)/\\u\\1/gc | %s/_\\([[:alnum:]]\\)/\\u\\1/g<CR>",
	{ desc = "snake[_]case to [c]amelCase" }
)
