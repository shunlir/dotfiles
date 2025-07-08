return function()
  local wk = require("which-key")
  wk.add({
    { "<leader>f", group = "file" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fp",
      "<cmd>lua require'telescope.builtin'.find_files{prompt_title='~ dotfiles ~', search_dirs={'~/.config/nvim'}} <cr>",
      desc = "Open Dotefiles" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },

    { "<leader>t", group = "toggle" },
    { "<leader>tv", "<Cmd>lua require('my.utils').diagnostics_toggle()<CR>", desc = "Toggle diagnostics" },
    { "<leader>tl", "<cmd>ToggleSignAndNumber<cr>", desc = "Toggle line" },
    { "<]eader>tf", "<cmd>ToggleFull<cr>", desc = "Toggle Full" },
    { "<]eader>th", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Toggle Source/Header" },

    { "<leader>wc", "<cmd>close<cr>", desc = "Close window" },

    { "<leader>lr", "<cmd>Telescope lsp_references theme=get_ivy<cr>", desc = "References" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols theme=get_ivy<cr>", desc = "Document Symbols" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols theme=get_ivy<cr>", desc = "Workspace  Symbols" },
    { "<leader>lx", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Document Diagnostic" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format Selection" },
    { "<leader>lF", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format File" },

    { "<leader>sp", "<cmd>Telescope live_grep_args theme=get_ivy<cr>", desc = "Search in project" },
    { "<leader>s.", function()
        local opts = { cwd = '%:p:h' }
        opts = require('telescope.themes').get_ivy(opts)
        require("telescope").extensions.live_grep_args.live_grep_args(opts)
      end,
      desc = "Search in current dir"},
    { "<leader>sb", function()
        local opts = { search_dirs = { vim.fn.expand('%:p') } }
        opts = require('telescope.themes').get_ivy(opts)
        require('telescope.builtin').live_grep(opts)
      end,
      desc = "Search in buffer" },

    { "<leader>pp", "<cmd>Telescope project theme=get_ivy<cr>", desc = "Select a project" },

    { "<leader>d", group = "debug" },
    { "<leader>dd", "<cmd>lua require'dap'.continue()<cr>", desc = "Start debugging" },
    { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
    { "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      desc = "Toggle breakpoint Cond" },
    { "<leader>dr", "<cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l<cr>", desc = "Toggle breakpoint Cond" },
    { "<F5>", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
    { "<F10>", "<cmd>lua require'dap'.step_over()<cr>", desc = "" },
    { "<F11>", "<cmd>lua require'dap'.step_into()<cr>", desc = "" },
    { "<F12>", "<cmd>lua require'dap'.step_out()<cr>", desc = "" },

    { "<leader><leader>", "<cmd>Telescope git_files<cr>", desc = "Find File" },
    { "<leader>,", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Switch Buffer" },
    { "<leader>.", function()
        local opts = { path = "%:p:h" }
        opts = require('telescope.themes').get_ivy(opts)
        require "telescope".extensions.file_browser.file_browser(opts)
      end,
      desc = "Files in current dir" },
    { "<leader>*", "<cmd>Telescope grep_string theme=get_ivy<cr>", desc = "Search current word in project" },
    -- { "<leader>\"", "<cmd>TroubleToggle<cr>", desc = "Toggle trouble list" },
    { "<leader>\"", "<cmd>lua require('telescope.builtin').pickers()<CR>", desc = "Toggle resume pickers" },
    { "<leader>'", "<cmd>Telescope resume theme=get_ivy<cr>", desc = "Telescope resume" },
    { "<leader>F", "<Cmd>lua require('my.utils').which_func()<CR>", desc = "Show Current Function" },
    { "<leader>R", function()
        local vimp = require('vimp')
        vimp.unmap_all()
        require("cfg.utils").unload_lua_namespace('cfg')
        package.loaded['plugins'] = nil
        vim.cmd('silent wa')
        dofile(vim.fn.stdpath('config') .. '/init.lua')
        vim.cmd('PackerCompile')
        print("Reloaded vimrc!")
      end,
      desc = "Reload vimrc!" }
  })

  -- wk.register({
  --   ["<leader>f"]        = { name = "+file" },
  --   ["<leader>ff"]       = { "<cmd>Telescope find_files<cr>", "Find File" },
  --   ["<leader>fp"]       = {
  --     "<cmd>lua require'telescope.builtin'.find_files{prompt_title='~ dotfiles ~', search_dirs={'~/.config/nvim'}} <cr>",
  --     "Open Dotefiles" },
  --   ["<leader>fr"]       = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  --
  --   ["<leader>t"]        = { name = "+toggle" },
  --   ["<leader>tv"]       = { "<Cmd>lua require('my.utils').diagnostics_toggle()<CR>", "Toggle diagnostics" },
  --   ["<leader>tl"]       = { "<cmd>ToggleSignAndNumber<cr>", "Toggle line" },
  --   ["<leader>tf"]       = { "<cmd>ToggleFull<cr>", "Toggle Full" },
  --   ["<leader>th"]       = { "<cmd>ClangdSwitchSourceHeader<cr>", "Toggle Source/Header" },
  --
  --   ["<leader>wc"]       = { "<cmd>close<cr>", "Close window" },
  --
  --   ["<leader>lr"]       = { "<cmd>Telescope lsp_references theme=get_ivy<cr>", "References" },
  --   ["<leader>ls"]       = { "<cmd>Telescope lsp_document_symbols theme=get_ivy<cr>", "Document Symbols" },
  --   ["<leader>lS"]       = { "<cmd>Telescope lsp_dynamic_workspace_symbols theme=get_ivy<cr>", "Workspace  Symbols" },
  --   ["<leader>lx"]       = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Document Diagnostic" },
  --   ["<leader>la"]       = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  --   ["<leader>lf"]       = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format Selection" },
  --   ["<leader>lF"]       = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format File" },
  --
  --   ["<leader>sp"]       = { "<cmd>Telescope live_grep_args theme=get_ivy<cr>", "Search in project" },
  --   ["<leader>s."]       = {
  --     function()
  --       local opts = { cwd = '%:p:h' }
  --       opts = require('telescope.themes').get_ivy(opts)
  --       require("telescope").extensions.live_grep_args.live_grep_args(opts)
  --     end,
  --     "Search in current dir"
  --   },
  --   ["<leader>sb"]       = {
  --     function()
  --       local opts = { search_dirs = { vim.fn.expand('%:p') } }
  --       opts = require('telescope.themes').get_ivy(opts)
  --       require('telescope.builtin').live_grep(opts)
  --     end,
  --     "Search in buffer"
  --   },
  --
  --   ["<leader>pp"]       = { "<cmd>Telescope project theme=get_ivy<cr>", "Select a project" },
  --
  --   ["<leader>d"]        = { name = "+debug" },
  --   ["<leader>dd"]       = { "<cmd>lua require'dap'.continue()<cr>", "Start debugging" },
  --   ["<leader>db"]       = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint" },
  --   ["<leader>dB"]       = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
  --     "Toggle breakpoint Cond" },
  --   ["<leader>dr"]       = { "<cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l<cr>", "Toggle breakpoint Cond" },
  --   ["<F5>"]             = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  --   ["<F10>"]            = { "<cmd>lua require'dap'.step_over()<cr>", "" },
  --   ["<F11>"]            = { "<cmd>lua require'dap'.step_into()<cr>", "" },
  --   ["<F12>"]            = { "<cmd>lua require'dap'.step_out()<cr>", "" },
  --
  --   ["<leader><leader>"] = { "<cmd>Telescope git_files<cr>", "Find File" },
  --   ["<leader>,"]        = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Switch Buffer" },
  --   ["<leader>."]        = {
  --     function()
  --       local opts = { path = "%:p:h" }
  --       opts = require('telescope.themes').get_ivy(opts)
  --       require "telescope".extensions.file_browser.file_browser(opts)
  --     end,
  --     "Files in current dir"
  --   },
  --   ["<leader>*"]        = { "<cmd>Telescope grep_string theme=get_ivy<cr>", "Search current word in project" },
  --   -- ["<leader>\""]       = { "<cmd>TroubleToggle<cr>", "Toggle trouble list" },
  --   ["<leader>\""]       = { "<cmd>lua require('telescope.builtin').pickers()<CR>", "Toggle resume pickers" },
  --   ["<leader>'"]        = { "<cmd>Telescope resume theme=get_ivy<cr>", "Telescope resume" },
  --   ["<leader>F"]        = { "<Cmd>lua require('my.utils').which_func()<CR>", "Show Current Function" },
  --   ["<leader>R"]        = {
  --     function()
  --       local vimp = require('vimp')
  --       vimp.unmap_all()
  --       require("cfg.utils").unload_lua_namespace('cfg')
  --       package.loaded['plugins'] = nil
  --       vim.cmd('silent wa')
  --       dofile(vim.fn.stdpath('config') .. '/init.lua')
  --       vim.cmd('PackerCompile')
  --       print("Reloaded vimrc!")
  --     end,
  --     "Reload vimrc!"
  --   },
  -- })
  -- wk.setup()
end
