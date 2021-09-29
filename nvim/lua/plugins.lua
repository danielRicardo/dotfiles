return require("packer").startup(function()

  use 'christoomey/vim-sort-motion'
  use 'christoomey/vim-tmux-navigator'
  use 'mfussenegger/nvim-dap'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'overcache/NeoSolarized'
  use 'scalameta/nvim-metals'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use {'hrsh7th/nvim-compe', requires = {{'hrsh7th/vim-vsnip'}}}
  use {'wbthomason/packer.nvim', opt = true}

end)
  


