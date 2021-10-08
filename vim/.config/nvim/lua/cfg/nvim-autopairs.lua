return function()
  require('nvim-autopairs').setup()
  -- mapping <CR>, requires nvim-compe:
  --[[
  Before        Input         After
  ------------------------------------
  {|}           <CR>          {
                                  |
                              }
  ------------------------------------
  ]]
  --[[
  require("nvim-autopairs.completion.compe").setup{
    map_cr = true, --  map <CR> on insert mode
  }
  ]]
end
