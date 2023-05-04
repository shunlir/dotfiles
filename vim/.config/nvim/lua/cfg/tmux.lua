return function()
  require("tmux").setup({
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    copy_sync = {
      -- enables copy sync and overwrites all register actions to
      -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
      enable = false,
    },
    navigation = {
      -- enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = false,
    },
    resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = false,
      resize_step_x = 5,
      resize_step_y = 5,
    }
  })
  local opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<M-h>", function() require("tmux").move_left() end, opts)
  vim.keymap.set("n", "<M-j>", function() require("tmux").move_bottom() end, opts)
  vim.keymap.set("n", "<M-k>", function() require("tmux").move_top() end, opts)
  vim.keymap.set("n", "<M-l>", function() require("tmux").move_right() end, opts)
  vim.keymap.set("n", "<M-H>", function() require("tmux").resize_left() end, opts)
  vim.keymap.set("n", "<M-J>", function() require("tmux").resize_bottom() end, opts)
  vim.keymap.set("n", "<M-K>", function() require("tmux").resize_top() end, opts)
  vim.keymap.set("n", "<M-L>", function() require("tmux").resize_right() end, opts)
end
