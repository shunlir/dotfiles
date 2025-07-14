return function()
  require("telescope").setup {
    defaults = {
      -- Your defaults config goes in here
      mappings = {
        i = {
          ["<C-f>"] = require('telescope.actions').results_scrolling_down,
          ["<C-b>"] = require('telescope.actions').results_scrolling_up,
          ["<c-l>"] = require("trouble.sources.telescope").open,
        },
        n = {
          ["<C-f>"] = require('telescope.actions').results_scrolling_down,
          ["<C-b>"] = require('telescope.actions').results_scrolling_up,
          ["<c-l>"] = require("trouble.sources.telescope").open,
        },
      },
      prompt_prefix = "$ ",
      cache_picker = {
        num_pickers = 5,
      },
    },
    pickers = {
      -- Your special builtin config goes in here
      buffers = {
        theme = 'ivy',
        sort_lastused = true,
        previewer = false,
      },
      find_files = { theme = 'ivy', path_display = {} },
      git_files = { theme = 'ivy', path_display = {} },
      file_browser = { theme = 'ivy', },
      oldfiles = { theme = 'ivy', },
      lsp_references = { theme = 'ivy', fname_width = 60, },
      pickers = { theme = 'ivy', },
    },
    extensions = {
      -- Your extension config goes in here
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_ivy {
          -- even more opts
        }
      },
      project = {
        base_dirs = {
          '~/repo'
        },
        theme = 'ivy'
      },
    }
  }

  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require('telescope').load_extension('fzf')
  require("telescope").load_extension "file_browser"
  require('telescope').load_extension('live_grep_args')
  require("telescope").load_extension("ui-select")
  require('telescope').load_extension('project')
end
