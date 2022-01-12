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

  -- look and feel
  use 'overcache/NeoSolarized'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- misc
  use 'christoomey/vim-tmux-navigator'


  use { 'wbthomason/packer.nvim', opt = true}

end)
  


