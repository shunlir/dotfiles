return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim",      lazy = true },
  -- icons
  { 'nvim-tree/nvim-web-devicons' }, -- It requires a pached front, such as 'Hack Nerd Font',
                                     -- and the terminal must be configured to use that font
  { "aserowy/tmux.nvim",          event = 'VeryLazy', config = require('cfg.tmux') },
  {
    'hoob3rt/lualine.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = require('cfg.lualine')
  },
  { 'lewis6991/gitsigns.nvim', event = { 'BufRead', 'BufNewFile' }, config = require('cfg.gitsigns') },

  -- fuzzy search
  { 'folke/trouble.nvim',      lazy = true,                         cmd = 'Trouble' },
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
  { 'ggandor/leap.nvim',  config = function()
      require('leap').add_default_mappings()
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end },

  -- editing enhance:
  { 'tpope/vim-surround', event = 'VeryLazy' }, -- surroundings manipulation
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = require(
      'cfg.nvim-autopairs')
  },
  { 'tpope/vim-sleuth',       event = 'InsertEnter' }, -- heuristically indent
  -- coment
  { 'numToStr/Comment.nvim',  event = 'VeryLazy',   config = function() require('Comment').setup() end },
  -- ga enhance
  { 'tpope/vim-characterize', event = 'VeryLazy',   keys = 'g' },

  -- completion, snippet
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = 'InsertEnter',
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
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = require 'cfg.nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',          build = ':MasonUpdate' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'p00f/clangd_extensions.nvim' },
    }
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = require 'cfg.null-ls',
    dependencies = {
      { 'williamboman/mason.nvim', build = ':MasonUpdate' },
    }
  },
  {
    'j-hui/fidget.nvim',
    lazy = true,
    event = 'LspAttach',
    config = function() require "fidget".setup {} end
  },

  -- dap (live-debugging)
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    -- ft = { 'c', 'cpp', 'cs' },
    config =
      require('cfg.nvim-dap')
  },

  { 'folke/which-key.nvim',          config = require('cfg.which-key') },

  {
    'TimUntersberger/neogit',
    -- event = 'VeryLazy', -- would cause blank welcome page
    config = function() require('neogit').setup {} end
  },
  { 'NvChad/nvim-colorizer.lua',     event = 'VeryLazy',               config = function() require('colorizer').setup {} end },

  -- highlight trailing whitespaces
  { 'ntpeters/vim-better-whitespace' },

  -- highlight current matched word when in hlsearch
  {
    'qxxxb/vim-searchhi',
    -- event = 'VeryLazy', -- would cause blank welcome page
    config = function()
      vim.cmd [[
    nmap n <Plug>(searchhi-n)
    nmap N <Plug>(searchhi-N)
    ]]
    end
  },

  -- themes
  -- { 'folke/lsp-colors.nvim' },
  -- { 'joshdick/onedark.vim', config = require('cfg.colors') },
  { 'navarasu/onedark.nvim', config = require('cfg.colors') },
  -- { 'folke/tokyonight.nvim', config = require('cfg.colors') },
  { 'folke/tokyonight.nvim', lazy = true },

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
