return function()
  vim.cmd[[
    augroup AgWhichKey
    autocmd ColorScheme * highlight! link WhichKeyGroup Directory
    autocmd ColorScheme * highlight! link WhichKey String
    autocmd ColorScheme * highlight! link WhichKeyDesc Statement
    augroup END
  ]]
  vim.cmd[[
    augroup AgTelescope
    autocmd ColorScheme * highlight! TelescopePromptPrefix ctermfg=red guifg=cyan
    autocmd ColorScheme * highlight! TelescopeMatching ctermfg=48 guifg=SpringGreen1
    autocmd ColorScheme * highlight! TelescopeSelectionCaret ctermfg=48 guifg=red
    augroup END
  ]]
  vim.cmd[[
    augroup AgMisc
    autocmd ColorScheme * highlight! IncSearch cterm=bold ctermfg=15 ctermbg=9 gui=bold guifg=#ffffff guibg=#f00077
    augroup END
  ]]
  vim.cmd('colorscheme onedark')
end
