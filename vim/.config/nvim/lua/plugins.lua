-- bootstrap packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then vim.fn.system({
    'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path
  })
end

return require('packer').startup(function(use)
  use {'wbthomason/packer.nvim'}
  use {'nvim-lua/plenary.nvim'}
  use {'nvim-lua/popup.nvim'}
  use {'svermeulen/vimpeccable'}
  -- icons
  use {'kyazdani42/nvim-web-devicons'}

  use {'kyazdani42/nvim-tree.lua', cmd = {'NvimTreeToggle'}}

  use {"aserowy/tmux.nvim", config = require('cfg.tmux')}

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', event = 'BufRead', config = require('cfg.nvim-treesitter')}

  use {'hoob3rt/lualine.nvim', config = require('cfg.lualine')}

  use {'lewis6991/gitsigns.nvim', event = {'BufRead','BufNewFile'},  config = function() require('gitsigns').setup() end}

  -- fuzzy search
  use {'folke/trouble.nvim', opt = true, cmd = 'Trouble', module = 'trouble.providers.telescope'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope.nvim', opt=true, cmd = 'Telescope', module = {'telescope.builtin','telescope.themes'}, config = require('cfg.telescope')}

  -- editor, motion enhance
  use {'andymass/vim-matchup', after = 'nvim-treesitter'}
  use {'windwp/nvim-autopairs', event = 'InsertEnter', config = require('cfg.nvim-autopairs')}
  use {'tpope/vim-sleuth', event = 'InsertEnter'} -- heuristically indent


  -- completion, snippet
  use {'hrsh7th/nvim-compe',config = require('cfg.compe')}
  use {'hrsh7th/vim-vsnip'}
  use {'hrsh7th/vim-vsnip-integ'}

  -- lsp (diagnostics, compe source, ...)
  use {'neovim/nvim-lspconfig'}
  use {'kabouzeid/nvim-lspinstall', config = require('cfg.lspinstall')}

  -- dap (live-debugging)
  use {'mfussenegger/nvim-dap', ft = {'c', 'cpp', 'cs'}, config = require('cfg.nvim-dap')}
  use {'shunlir/DAPInstall.nvim'}

  use {'folke/which-key.nvim', config = require('cfg.which-key')}


  -- highlight current matched word when in hlsearch
  use {'qxxxb/vim-searchhi', config = function()
    vim.cmd[[
    nmap n <Plug>(searchhi-n)
    nmap N <Plug>(searchhi-N)
    ]]
  end}

  -- themes
  use {'joshdick/onedark.vim', config = require('cfg.colors')}

  use {'tweekmonster/startuptime.vim', cmd = 'StartupTime'}

end)
