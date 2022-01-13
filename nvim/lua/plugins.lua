return require("packer").startup(function()

  -- vim enhancements
  use 'AndrewRadev/linediff.vim'
  use 'christoomey/vim-sort-motion'
  use 'easymotion/vim-easymotion'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'vim-test/vim-test'
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}} }

  -- git related
  use 'junegunn/gv.vim'
  use 'mhinz/vim-signify'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  
  -- LSP
  use 'mfussenegger/nvim-dap'
  use 'neovim/nvim-lspconfig'
  use { 'hrsh7th/nvim-compe', requires = {{'hrsh7th/vim-vsnip'}} }

  -- scala
  use { 'scalameta/nvim-metals', requires = {{"nvim-lua/plenary.nvim"}} }

  -- clojure
  use 'Olical/conjure'
  use 'clojure-vim/vim-jack-in'
  use 'tami5/compe-conjure'

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

end)
  


