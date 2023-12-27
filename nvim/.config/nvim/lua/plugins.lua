----------------------------------
-- PLUGINS -----------------------
----------------------------------

local plugins = function (use)
  use { 'wbthomason/packer.nvim' }

  -- vim enhancements
  use { 'AndrewRadev/linediff.vim' }
  use { 'christoomey/vim-sort-motion' }
  use { 'phaazon/hop.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-lua/popup.nvim' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'vim-test/vim-test' }
  use { 'nvim-telescope/telescope.nvim', requires = {  'nvim-telescope/telescope-fzy-native.nvim' } }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'rcarriga/nvim-notify' }
  use { 'numToStr/Comment.nvim', config = "require('Comment').setup()" }
  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      {'nvim-telescope/telescope.nvim'},
    },
    config = function()
      require('neoclip').setup()
    end,
  }

  -- git related
  use { 'junegunn/gv.vim' }
  use { 'mhinz/vim-signify' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-rhubarb' }

  -- snippets
  use { 'L3MON4D3/LuaSnip' }
  use { 'rafamadriz/friendly-snippets' }

  -- LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { 'neovim/nvim-lspconfig' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'windwp/nvim-autopairs' } --, after = { "nvim-treesitter", "nvim-cmp" } }
  use { 'p00f/nvim-ts-rainbow', after = "nvim-treesitter" }
  use { 'nvim-treesitter/nvim-treesitter-refactor', after = "nvim-treesitter" }
  use { 'hrsh7th/nvim-cmp', requires = { 'onsails/lspkind-nvim', 'hrsh7th/cmp-nvim-lsp' }}--, after = "LuaSnip" }
  use { 'hrsh7th/cmp-buffer', after = "nvim-cmp" }
  use { 'hrsh7th/cmp-path', after = "nvim-cmp" }
  use { 'andersevenrud/cmp-tmux', after = "nvim-cmp" }
  use { 'glepnir/lspsaga.nvim', branch = "main" }

  -- DAP
  use { 'mfussenegger/nvim-dap' }
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  -- scala
  use { 'scalameta/nvim-metals',  config = "require('settings.metals').setup()" }

  -- clojure
  use { 'Olical/conjure' }
  use { 'PaterJason/cmp-conjure', after = { "nvim-cmp", "conjure" } }
  use { 'clojure-vim/vim-jack-in', after = "conjure" }
  use { 'guns/vim-sexp' }
  use { 'tpope/vim-sexp-mappings-for-regular-people', after = "vim-sexp" }

  -- look and feel
  use { "projekt0n/github-nvim-theme", commit = '715c554' }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  -- external environment communication
  use { 'christoomey/vim-tmux-navigator' }
  use { 'tpope/vim-dispatch' }
  use { 'radenling/vim-dispatch-neovim' }

end

----------------------------------
-- BOOTSTRAP PACKER --------------
----------------------------------

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.notify('Installed Packer. Please restart Neovim')
  vim.cmd [[ packadd packer.nvim ]]
end

local packerUserConfGroup = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "source <afile> | PackerCompile",
  group = packerUserConfGroup
})

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer initialization failed", vim.log.levels.ERROR)
  return
end

----------------------------------
-- INITIALIZE --------------------
----------------------------------

return packer.startup({
  function(use)
    plugins(use)

    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end

  end,
  config = {
    display = {
      open_fn = function ()
        return require("packer.util").float { border = "rounded" }
      end
    }
  }
})



