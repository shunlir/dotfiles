return function()
  vim.cmd [[
    augroup AgWhichKey
    autocmd ColorScheme * highlight! link WhichKeyGroup Directory
    autocmd ColorScheme * highlight! link WhichKey String
    autocmd ColorScheme * highlight! link WhichKeyDesc Statement
    augroup END
  ]]

  -- autocmd ColorScheme * highlight! TelescopeMatching ctermfg=48 guifg=SpringGreen1
  vim.cmd [[
    augroup AgTelescope
    autocmd ColorScheme * highlight! TelescopePromptPrefix ctermfg=red guifg=cyan
    autocmd ColorScheme * highlight! TelescopeMatching     guifg=SpringGreen guibg=NONE gui=bold ctermfg=85 ctermbg=NONE cterm=bold
    autocmd ColorScheme * highlight! TelescopeSelectionCaret ctermfg=48 guifg=red
    autocmd ColorScheme * highlight! TelescopeSelection      ctermfg=226 guifg=Yellow
    augroup END
  ]]
  vim.cmd [[
    augroup AgMisc
    autocmd ColorScheme * highlight! IncSearch cterm=bold ctermfg=15 ctermbg=9 gui=bold guifg=#ffffff guibg=#f00077
    autocmd ColorScheme * highlight! CmpItemAbbrMatchFuzzy guifg=#56B6C2
    autocmd ColorScheme * highlight! CmpItemAbbrMatch guifg=#56B6C2
    augroup END
  ]]
  vim.cmd('colorscheme onedark')
end
