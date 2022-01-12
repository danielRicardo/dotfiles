return require("packer").startup(function()

  use 'AndrewRadev/linediff.vim'
  use 'christoomey/vim-sort-motion'
  use 'christoomey/vim-tmux-navigator'
  use 'easymotion/vim-easymotion'
  use 'junegunn/gv.vim'
  use 'mfussenegger/nvim-dap'
  use 'mhinz/vim-signify'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'overcache/NeoSolarized'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'vim-test/vim-test'
  use { 'hrsh7th/nvim-compe', requires = {{'hrsh7th/vim-vsnip'}} }
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}} }
  use { 'scalameta/nvim-metals', requires = {{"nvim-lua/plenary.nvim"}} }

  use { 'wbthomason/packer.nvim', opt = true}

end)
  


