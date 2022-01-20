----------------------------------
-- PLUGINS -----------------------
----------------------------------

local plugins = function (use)
  -- vim enhancements
  use 'AndrewRadev/linediff.vim'
  use 'christoomey/vim-sort-motion'
  use 'phaazon/hop.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'vim-test/vim-test'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'rcarriga/nvim-notify'

  -- git related
  use 'junegunn/gv.vim'
  use 'mhinz/vim-signify'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- LSP
  use 'mfussenegger/nvim-dap'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      { 'p00f/nvim-ts-rainbow' },
      { 'windwp/nvim-autopairs' },
      { 'nvim-treesitter/nvim-treesitter-refactor' },
    },
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/vim-vsnip' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'andersevenrud/cmp-tmux' },
      { 'onsails/lspkind-nvim' },
      { 'PaterJason/cmp-conjure' }
    }
  }


  -- scala
  use { 'scalameta/nvim-metals', requires = {{"nvim-lua/plenary.nvim"}} }

  -- clojure
  use 'Olical/conjure'
  use 'clojure-vim/vim-jack-in'
  use 'tami5/compe-conjure'
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'

  -- look and feel
  use "projekt0n/github-nvim-theme"
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- external environment communication
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-dispatch'
  use 'radenling/vim-dispatch-neovim'


  use { 'wbthomason/packer.nvim', opt = true}
end

----------------------------------
-- BOOTSTRAP PACKER --------------
----------------------------------

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer initialization failed", vim.log.levels.ERROR)
  return
end

----------------------------------
-- INITIALIZE --------------------
----------------------------------

return require("packer").startup({
  function(use)
    plugins(use)

    if packer_bootstrap then
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



