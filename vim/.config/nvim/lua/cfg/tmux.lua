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
  vimp = require('vimp')
  opts = {'silent'}
  vimp.bind(opts, '<M-h>', [[<cmd>lua require("tmux").move_left()<cr>]])
  vimp.bind(opts, '<M-j>', [[<cmd>lua require("tmux").move_bottom()<cr>]])
  vimp.bind(opts, '<M-k>', [[<cmd>lua require("tmux").move_top()<cr>]])
  vimp.bind(opts, '<M-l>', [[<cmd>lua require("tmux").move_right()<cr>]])
  vimp.bind(opts, '<M-H>', [[<cmd>lua require("tmux").resize_left()<cr>]])
  vimp.bind(opts, '<M-J>', [[<cmd>lua require("tmux").resize_bottom()<cr>]])
  vimp.bind(opts, '<M-K>', [[<cmd>lua require("tmux").resize_top()<cr>]])
  vimp.bind(opts, '<M-L>', [[<cmd>lua require("tmux").resize_right()<cr>]])
end
