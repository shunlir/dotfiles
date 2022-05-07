return function()
  require("telescope").setup {
    defaults = {
      -- Your defaults config goes in here
      mappings = {
        i = { ["<c-l>"] = require'trouble.providers.telescope'.open_with_trouble },
        n = { ["<c-l>"] = require'trouble.providers.telescope'.open_with_trouble },
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
      find_files = {theme = 'ivy', path_display = {}},
      git_files = {theme = 'ivy', path_display = {}},
      file_browser = {theme = 'ivy',},
      oldfiles = {theme = 'ivy',},
      lsp_references = {theme = 'ivy',},
      pickers = {theme = 'ivy',},
    },
    extensions = {
      -- Your extension config goes in here
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_ivy{
          -- even more opts
        }
      },
    }
  }

  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require('telescope').load_extension('fzf')
  require("telescope").load_extension "file_browser"
  require("telescope").load_extension("ui-select")
end
