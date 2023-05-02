return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  { 'svermeulen/vimpeccable' },

  -- icons
  { 'nvim-tree/nvim-web-devicons' },

  { 'kyazdani42/nvim-tree.lua',   cmd = { 'NvimTreeToggle' } },
  { "aserowy/tmux.nvim",          config = require('cfg.tmux') },
  { 'hoob3rt/lualine.nvim',       config = require('cfg.lualine') },
  { 'lewis6991/gitsigns.nvim',    event = { 'BufRead', 'BufNewFile' }, config = require('cfg.gitsigns') },

  -- fuzzy search
  { 'folke/trouble.nvim',         lazy = true,                         cmd = 'Trouble' },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = 'Telescope',
    config = require('cfg.telescope'),
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make' },
      { 'nvim-telescope/telescope-file-browser.nvim',   lazy = true },
      { 'nvim-telescope/telescope-project.nvim',        lazy = true },
      { 'nvim-telescope/telescope-live-grep-args.nvim', lazy = true },
      { 'nvim-telescope/telescope-ui-select.nvim',      lazy = true }
    }
  },

  -- motion enhance:
  {
    'andymass/vim-matchup',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile', }
  }, -- % enhance
  { 'ggandor/lightspeed.nvim' },

  -- editing enhance:
  { 'tpope/vim-surround' },                               -- surroundings manipulation
  { 'windwp/nvim-autopairs',     config = require('cfg.nvim-autopairs') },
  { 'tpope/vim-sleuth',          event = 'InsertEnter' }, -- heuristically indent
  -- coment
  { 'numToStr/Comment.nvim',     config = function() require('Comment').setup() end },
  -- formatter
  { 'gpanders/editorconfig.nvim' },
  -- ga enhance
  { 'tpope/vim-characterize',    lazy = false,                                      keys = 'g' },

  -- completion, snippet
  {
    "hrsh7th/nvim-cmp",
    config = require('cfg.cmp'),
    -- lazy = true,
    -- event = "InsertEnter",
    dependencies = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip',    -- source: vsnip
      'hrsh7th/cmp-buffer',   -- source: buffer
      'hrsh7th/cmp-nvim-lsp', -- source: nvim_lsp
      'hrsh7th/cmp-nvim-lua', -- source: nvim_lua
      'hrsh7th/cmp-path',     -- source: path
      'hrsh7th/cmp-calc',     -- source: calc
      'hrsh7th/cmp-cmdline',  -- source: cmdline for vim's cmdline
    }
  },

  -- lsp (diagnostics, compe source, ...)
  { 'williamboman/mason.nvim',          build = ':MasonUpdate' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig',            config = require 'cfg.nvim-lspconfig' },
  { 'p00f/clangd_extensions.nvim' },
  {
    'j-hui/fidget.nvim',
    config = function()
      require "fidget".setup {}
    end
  },
  { 'jose-elias-alvarez/null-ls.nvim', config = require 'cfg.null-ls' },

  -- dap (live-debugging)
  {
    'mfussenegger/nvim-dap',
    ft = { 'c', 'cpp', 'cs' },
    config =
      require('cfg.nvim-dap')
  },

  { 'folke/which-key.nvim',            config = require('cfg.which-key') },
  { 'TimUntersberger/neogit',          config = function() require('neogit').setup {} end },
  { 'norcalli/nvim-colorizer.lua',     config = function() require('colorizer').setup { 'xdefaults', 'tmux' } end },

  -- highlight trailing whitespaces
  { 'ntpeters/vim-better-whitespace' },
  -- highlight current matched word when in hlsearch
  {
    'qxxxb/vim-searchhi',
    config = function()
      vim.cmd [[
    nmap n <Plug>(searchhi-n)
    nmap N <Plug>(searchhi-N)
    ]]
    end
  },

  -- themes
  { 'folke/lsp-colors.nvim' },
  { 'joshdick/onedark.vim', config = require('cfg.colors') },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = require("cfg.nvim-treesitter"),
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" }
    }
  },

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
