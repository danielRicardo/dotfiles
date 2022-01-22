local indent = 2

local global_options = {
  termguicolors = true,
  hidden = true,
  showtabline = 1,
  updatetime = 300,
  showmatch = true,
  laststatus = 2,
  wildignore = { '.git', '*/node_modules/*', '*/target/*', '.metals', '.bloop', '.ammonite' },
  ignorecase = true,
  smartcase = true,
  completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' },
}

local options = {
  -- window-scoped
  wrap = false,
  cursorline = true,
  signcolumn = 'yes',
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  background = 'dark',

  -- buffer-scoped
  tabstop = indent,
  expandtab = true,
  fileformat = 'unix',
}

for k, v in pairs(global_options) do
  vim.opt_global[k] = v
end

for k, v in pairs(options) do
  vim.opt[k] = v
end
