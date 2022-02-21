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
  use {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter', config = require('cfg.nvim-treesitter-textobjects')}

  use {'hoob3rt/lualine.nvim', config = require('cfg.lualine')}

  use {'lewis6991/gitsigns.nvim', event = {'BufRead','BufNewFile'},  config = require('cfg.gitsigns')}

  -- fuzzy search
  use {'folke/trouble.nvim', opt = true, cmd = 'Trouble', module = 'trouble.providers.telescope'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope.nvim', opt=true, cmd = 'Telescope', module = {'telescope.builtin','telescope.themes'}, config = require('cfg.telescope')}
  use { 'nvim-telescope/telescope-file-browser.nvim' }

  -- editor, motion enhance
  use {'andymass/vim-matchup', after = 'nvim-treesitter'}
  use {'windwp/nvim-autopairs', config = require('cfg.nvim-autopairs')}
  use {'tpope/vim-sleuth', event = 'InsertEnter'} -- heuristically indent


  -- completion, snippet
  --use {'hrsh7th/nvim-compe',config = require('cfg.compe')}
  --use {'hrsh7th/vim-vsnip'}
  --use {'hrsh7th/vim-vsnip-integ'}
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip',    -- source: vsnip
      'hrsh7th/cmp-buffer',   -- source: buffer
      'hrsh7th/cmp-nvim-lsp', -- source: nvim_lsp
      'hrsh7th/cmp-nvim-lua', -- source: nvim_lua
      'hrsh7th/cmp-path',     -- source: path
      'hrsh7th/cmp-calc',     -- source: calc
    },
    config = require('cfg.cmp')
  }

  -- lsp (diagnostics, compe source, ...)
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/nvim-lsp-installer', config = require'cfg.nvim-lsp-installer'}

  -- dap (live-debugging)
  use {'mfussenegger/nvim-dap', ft = {'c', 'cpp', 'cs'}, config = require('cfg.nvim-dap')}
  use {'shunlir/DAPInstall.nvim'}

  use {'folke/which-key.nvim', config = require('cfg.which-key')}

  use {'TimUntersberger/neogit', config = function() require('neogit').setup{} end}

  use {'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup{'xdefaults', 'tmux'} end}

  -- highlight current matched word when in hlsearch
  use {'qxxxb/vim-searchhi', config = function()
    vim.cmd[[
    nmap n <Plug>(searchhi-n)
    nmap N <Plug>(searchhi-N)
    ]]
  end}

  use {'ggandor/lightspeed.nvim'}

  -- themes
  use {'folke/lsp-colors.nvim'}
  use {'joshdick/onedark.vim', config = require('cfg.colors')}

  use {'tweekmonster/startuptime.vim', cmd = 'StartupTime'}
  use {'vim-scripts/DoxygenToolkit.vim'}

end)
