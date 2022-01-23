----------------------------------
-- PLUGINS -----------------------
----------------------------------

local plugins = function (use)
  -- vim enhancements
  use { 'AndrewRadev/linediff.vim' }
  use { 'christoomey/vim-sort-motion' }
  use { 'phaazon/hop.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-lua/popup.nvim' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'vim-test/vim-test', config = "require('settings.vim-test')" }
  use { 'nvim-telescope/telescope.nvim', config = "require('settings.telescope').setup()", requires = {  'nvim-telescope/telescope-fzy-native.nvim' } }
  use { 'kyazdani42/nvim-tree.lua', config = "require('settings.nvim-tree').setup()" }
  use { 'rcarriga/nvim-notify', config = "require('settings.notify').setup()" }

  -- git related
  use { 'junegunn/gv.vim' }
  use { 'mhinz/vim-signify', config = "require('settings.signify').setup()" }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-rhubarb' }

  -- snippets
  use { 'L3MON4D3/LuaSnip' }
  use { 'rafamadriz/friendly-snippets' }

  -- LSP
  use { 'mfussenegger/nvim-dap', config = "require('settings.dap').setup()" }
  use { 'neovim/nvim-lspconfig', config = "require('settings.lsp').setup()" }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = "require('settings.treesitter').setup()" }
  use { 'windwp/nvim-autopairs' , config = "require('settings.autopairs').setup()", after = { "nvim-treesitter", "nvim-cmp" } }
  use { 'p00f/nvim-ts-rainbow', after = "nvim-treesitter" }
  use { 'nvim-treesitter/nvim-treesitter-refactor', after = "nvim-treesitter" }
  use { 'nvim-treesitter/playground' }
  use { 'hrsh7th/nvim-cmp', config = "require('settings.cmp').setup()", requires = { 'onsails/lspkind-nvim', 'hrsh7th/cmp-nvim-lsp' }, after = "LuaSnip" }
  use { 'hrsh7th/cmp-buffer', after = "nvim-cmp" }
  use { 'hrsh7th/cmp-path', after = "nvim-cmp" }
  use { 'andersevenrud/cmp-tmux', after = "nvim-cmp" }

  -- scala
  use { 'scalameta/nvim-metals',  config = "require('settings.metals').setup()" }

  -- clojure
  use { 'Olical/conjure' }
  use { 'PaterJason/cmp-conjure', after = { "nvim-cmp", "conjure" } }
  use { 'clojure-vim/vim-jack-in', after = "conjure" }
  use { 'guns/vim-sexp' }
  use { 'tpope/vim-sexp-mappings-for-regular-people', after = "vim-sexp" }

  -- look and feel
  use { "projekt0n/github-nvim-theme" }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }, config = "require('settings.lualine').setup()" }

  -- external environment communication
  use { 'christoomey/vim-tmux-navigator' }
  use { 'tpope/vim-dispatch' }
  use { 'radenling/vim-dispatch-neovim' }


  use { 'wbthomason/packer.nvim', opt = true}
end

----------------------------------
-- BOOTSTRAP PACKER --------------
----------------------------------

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.notify('Installed Packer. Please restart Neovim')
  vim.cmd [[ packadd packer.nvim ]]
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

return packer.startup({
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



