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
  vim.cmd('colorscheme onedark')
end
