vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

local indent = 2

local global_options = {
	termguicolors = true,
	hidden = true,
	showtabline = 1,
	updatetime = 300,
	showmatch = true,
	laststatus = 2,
	wildignore = { ".git", "*/node_modules/*", "*/target/*", ".metals", ".bloop", ".ammonite" },
	ignorecase = true,
	smartcase = true,
	completeopt = { "menu", "menuone", "noinsert", "noselect" },
	hlsearch = true,

	-- Sync clipboard between OS and Neovim.
	clipboard = "unnamedplus",

	breakindent = true,
	undofile = true,
}

local options = {
	-- window-scoped
	wrap = false,
	cursorline = true,
	signcolumn = "yes",
	number = true,
	relativenumber = true,
	shiftwidth = 2,
	softtabstop = 2,
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	background = "dark",

	-- buffer-scoped
	tabstop = indent,
	expandtab = true,
	fileformat = "unix",

	-- Decrease update time
	updatetime = 250,

	-- Decrease mapped sequence wait time
	-- Displays which-key popup sooner
	timeoutlen = 300,

	-- Preview substitutions live, as you type!
	inccommand = "split",

	-- Minimal number of screen lines to keep above and below the cursor.
	scrolloff = 10,
}

for k, v in pairs(global_options) do
	vim.opt_global[k] = v
end

for k, v in pairs(options) do
	vim.opt[k] = v
end
