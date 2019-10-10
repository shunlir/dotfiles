set nocompatible

"VimPlugSelfBoot {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  ~/.vim/autoload/plug.vim'
  augroup plugsetup
    au!
    autocmd VimEnter * PlugInstall
  augroup end
endif
"}}}

call plug#begin('~/.vim/plugged')

"General {{{
    " Tab and Space
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    filetype plugin indent on
    autocmd FileType make setlocal noexpandtab
    autocmd FileType vim setlocal softtabstop=2 shiftwidth=2 expandtab

    " Searching
    set ignorecase "case insensitive searching
    set smartcase  "case-sensitive if expresson contains a capital letter (typed only)
    set incsearch  "incremental search
    set hlsearch   "highlight search results

    " Miscs
    set wildmenu   "vim buildin command line completion
"    if has('mouse')
"      set mouse=a
"    endif
    if !(has("nvim"))
      set clipboard=exclude:.* "disable system clibpard
    endif

    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    " trim trailing whitespace
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
    command! TrimWhitespace call TrimWhitespace()
"}}}

"Appearence {{{
"
    "LineNumber {{{
        set number
        Plug 'jeffkreeftmeijer/vim-numbertoggle'
        "cmd - ToggleLineNumber
        function! Toggle_LineNumber()
            if &number == 1 ||  &relativenumber == 1
                let &number=0
                let &relativenumber=0
            else
                let &number=1
                let &relativenumber=1
            endif
        endfunction
        command! -nargs=0 ToggleLineNumber call Toggle_LineNumber()
    "}}}

    "Colors {{{
        " force 256 color
        " if !has('gui_running')
        "   set t_Co=256
        " endif

        " optionally enable true color
        if $COLORTERM == "truecolor" && has("termguicolors")
            if !(has("nvim"))
                let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
                let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
            endif
            set termguicolors
        endif

        " color schemes
        Plug 'shunlir/vim-dim'
    "}}}

    "StatusLine {{{
        set laststatus=2 "always display the status line
        set noshowmode
        Plug 'itchyny/lightline.vim'

        " show unicode value of char under cursor
        "let g:lightline = {
        "    \ 'active': {
        "    \     'right': [ [ 'lineinfo', 'charcode' ],
        "    \                [ 'percent' ],
        "    \                [ 'fileformat', 'fileencoding', 'filetype' ] ]
        "    \ },
        "    \ 'component_function': {
        "    \     'charcode': 'LightlineCharcode'
        "    \ }
        "    \ }
        "function! LightlineCharcode() abort
        "  let line = getline('.')
        "  let col = col('.')
        "  return col - 1 < len(line) ? printf('U+%04x', char2nr(matchstr(line[(col - 1):], '^.'))) : ''
        "endfunction
        let g:lightline = {
              \ 'colorscheme': 'jellybeans'
              \ }
    "}}}

    "SignColumn {{{
        "cmd - ToggleSignColum
        if exists("&signcolumn")
            function! Toggle_SignColumn()
                if &signcolumn == 'yes' || &signcolumn == 'auto'
                    let &signcolumn='no'
                else
                    let &signcolumn='yes'
                endif
            endfunction
            command! -nargs=0 ToggleSignColumn call Toggle_SignColumn()
        endif

        Plug 'mhinz/vim-signify'
        let g:signify_vcs_list = [ 'git', 'hg' ]
        autocmd ColorScheme *
                  \ highlight clear SignColumn |
                  \ highlight SignifySignAdd    term=bold ctermbg=none  ctermfg=green |
                  \ highlight SignifySignDelete term=bold ctermbg=none  ctermfg=red   |
                  \ highlight SignifySignChange term=bold ctermbg=none  ctermfg=yellow
    "}}}



    "Plug 'godlygeek/tabular'
    "Plug 'plasticboy/vim-markdown'
"}}}

"FileExplorer {{{
    Plug 'justinmk/vim-dirvish'
"}}}


"FuzzyFinder {{{
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } " default use 256 color for TUI
    let g:Lf_ShortcutF = '<C-p>'  " Ctrl+P - all files
    let g:Lf_ShortcutB = '<M-p>'  " Alt+P  - opened files
    let g:Lf_CommandMap = {'<C-K>': ['<C-P>'], '<C-J>': ['<C-N>']}
    noremap <M-m> :LeaderfMru<cr>
    noremap <M-f> :LeaderfFunction!<cr>
    noremap <M-t> :LeaderfTag<cr>
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
    let g:Lf_WildIgnore = { 'dir': ['.svn','.git','.hg'], 'file': [] }
    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_CacheDirectory = expand('~/.vim/cache')
    let g:Lf_ShowRelativePath = 0
    let g:Lf_HideHelp = 1
    let g:Lf_StlColorscheme = 'powerline'
    let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
"}}}


"Mappings {{{
    let mapleader = " "
    " toggle quickfix window
    nnoremap <F8> :call asyncrun#quickfix_toggle(6)<cr>
    " toggle paste mode
    noremap <F9> :set paste!<cr>
    " toggle sign column
    noremap <F10> :ToggleSignColumn<CR>
    " Reload .vimrc
    nnoremap <Leader>R :source $MYVIMRC<CR>
    " split window
    map <Leader>w- :split<CR>
    map <Leader>w. :vsplit<CR>
    " toggle maximize window and resize windows
    function! s:ToggleResize() abort
        if winnr('$') > 1
            if exists('t:zoomed') && t:zoomed
                execute t:zoom_winrestcmd
                let t:zoomed = 0
                echo 'Windows resized.'
            else
                let t:zoom_winrestcmd = winrestcmd()
                resize
                vertical resize
                let t:zoomed = 1
                echo 'Window maximized.'
            endif
        endif
    endfunction
    autocmd VimEnter * autocmd WinEnter * let t:zoomed = 0
    nnoremap <Leader>wf :call <SID>ToggleResize()<CR>

    "VimTuiMetaKey {{{
    " set keycode of some <M-?> to use <ESC> prefix, see :map-alt-keys
    function! TUI_MetaUseEsc()
        set ttimeout
        if !empty($TMUX)       "tmux is expected to set its own escape-time to 50
            set ttimeoutlen=30
        elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
            set ttimeoutlen=80
        endif
        if has('nvim') || has('gui_running')
            return
        endif
        function! s:metacode(key)
            exec "set <M-".a:key.">=\e".a:key
        endfunc
        for i in range(10)
            call s:metacode(nr2char(char2nr('0') + i))
        endfor
        for i in range(26)
            call s:metacode(nr2char(char2nr('a') + i))
            call s:metacode(nr2char(char2nr('A') + i))
        endfor
        for c in [',', '.', '/', ';']
            call s:metacode(c)
        endfor
    endfunc
    call TUI_MetaUseEsc()
    "}}}

    "TmuxIntegration {{{
        Plug 'christoomey/vim-tmux-navigator'
        let g:tmux_navigator_no_mappings = 1
        nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
        nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
        nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
        nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
        nnoremap <silent> <M-r> :TmuxNavigatePrevious<cr>
        Plug 'melonmanchan/vim-tmux-resizer'
        let g:tmux_resizer_no_mappings = 1
        nnoremap <silent> <M-H> :TmuxResizeLeft<cr>
        nnoremap <silent> <M-J> :TmuxResizeDown<cr>
        nnoremap <silent> <M-K> :TmuxResizeUp<cr>
        nnoremap <silent> <M-L> :TmuxResizeRight<cr>
        Plug 'benmills/vimux'
        map <Leader>vp :VimuxPromptCommand<cr>
    "}}}
"}}}

"GeneralFunctionality {{{
    Plug 'tpope/vim-surround'
    " Matchit- Extended '%' matching
    Plug 'adelarsq/vim-matchit'
    " Git wrapper
    Plug 'tpope/vim-fugitive'
    "AsyncRun {{{
        Plug 'skywind3000/asyncrun.vim'
        let g:asyncrun_open = 6
        let g:asyncrun_bell = 1
    "}}}
"}}}

"LanguageSpecificConfiguration {{{
    "C/C++ {{{
        "YCM {{{
            function! BuildYCM(info)
                " info is a dictionary with 3 fields
                " - name:   name of the plugin
                " - status: 'installed', 'updated', or 'unchanged'
                " - force:  set on PlugInstall! or PlugUpdate!
                if a:info.status == 'installed' || a:info.force
                    !./install.py
                endif
            endfunction
            "Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
        "}}}
        "Uncrustify cmd - UC {{
            " Restore cursor position, window position, and last search after running a command.
            function! Preserve(command)
              " Save the last search.
              let search = @/

              " Save the current cursor position.
              let cursor_position = getpos('.')

              " Save the current window position.
              normal! H
              let window_position = getpos('.')
              call setpos('.', cursor_position)

              " Execute the command.
              execute a:command

              " Restore the last search.
              let @/ = search

              " Restore the previous window position.
              call setpos('.', window_position)
              normal! zt

              " Restore the previous cursor position.
              call setpos('.', cursor_position)
            endfunction

            " Specify path to your Uncrustify configuration file.
            let g:uncrustify_cfg_file_path =
                \ shellescape(fnamemodify('~/.uncrustify.cfg', ':p'))

            function! Uncrustify(language)
              call Preserve(':silent %!uncrustify'
                  \ . ' -q '
                  \ . ' -l ' . a:language
                  \ . ' -c ' . g:uncrustify_cfg_file_path)
            endfunction
            function! UC()
                let exts = {"cpp": "cpp", "c": "c"}
                let ext = expand('%:e')
                if has_key(exts, ext)
                    call Uncrustify(ext)
                endif
            endfunction
            command! UC call UC()
        "}}}
    "}}}
    "CTags {{{
        set tags=./.tags;,.tags  " upward search .tags from the dir of the file being edit, if not found, search .tags in `pwd`
        "Plug 'ludovicchabant/vim-gutentags'
        let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
        let g:gutentags_ctags_tagfile = '.tags'
        let s:vim_tags = expand('~/.cache/tags')
        let g:gutentags_cache_dir = s:vim_tags
        let g:gutentags_file_list_command = {
            \ 'markers': {
                \ '.git': 'git ls-files',
                \ '.hg': 'hg files',
                \ },
            \ }
        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
    "}}}
"}}}

call plug#end()


"Finalsetup {{{
  if has('gui_running')
      set background=light
  else
      set background=dark
  endif
  syntax enable
  colorscheme dim
"}}}
