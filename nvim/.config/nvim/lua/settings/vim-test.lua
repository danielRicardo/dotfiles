local g = vim.g
local v = vim.v

g['test#strategy'] = {
  nearest = 'neovim',
  file = 'neovim',
  suite = 'neovim'
}

g['test#neovim#term_position'] = 'vert'

g['test#scala#runner'] = 'blooptest'

g['test#neovim#start#normal'] = 1
