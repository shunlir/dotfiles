">> General Vim settings
set incsearch    " enable realtime search
set ignorecase   " case-insensive when searching
set hlsearch     " highlight all matches of previous search pattern
set nocompatible " be iMproved
set wildmenu     " show menu for vim command when typing TAB key

set nowrap       " no line wrap

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"seg_vimrc-begin

">> vim-plug section
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'

call plug#end()
"<<

">> general performance tunning
set clipboard=exclude:.*
"<<

">> tuning the sign column
if exists("&signcolumn")
  function! Toggle_SignColumn()
    if &signcolumn == 'yes' || &signcolumn == 'auto'
      let &signcolumn='no'
    else
      let &signcolumn='yes'
    endif
  endfunction
  noremap <F10> :call Toggle_SignColumn()<cr>
endif
highlight clear SignColumn
"<<

">> statusline
set laststatus=2
set noshowmode
if !has('gui_running')
  set t_Co=256
endif
"<<

">> signify
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
" highlight signs in Sy
highlight SignifySignAdd    cterm=bold ctermbg=none ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=none ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=none ctermfg=227
"<<

"seg_vimrc-end
