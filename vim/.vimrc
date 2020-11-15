set nocompatible

"VimPlug {{{
" auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  ~/.vim/autoload/plug.vim'
  augroup plugsetup
    au!
    autocmd VimEnter * PlugInstall
  augroup end
endif

call plug#begin('~/.vim/plugged')
    " heuristically indent
    Plug 'tpope/vim-sleuth'
    " line number
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    " color schemes
    Plug 'shunlir/vim-dim'
    Plug 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'
    " status line
    Plug 'itchyny/lightline.vim'
    " display color, optional: golang is used for async display
    Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
    " highlighted yank
    Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 100
    " diff on sign column
    Plug 'mhinz/vim-signify'
    " file explorer
    Plug 'justinmk/vim-dirvish'
    " fuzzy finder
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } " default use 256 color for TUI
    " keys
    Plug 'liuchengxu/vim-which-key'
    " Tmux
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'melonmanchan/vim-tmux-resizer'
    Plug 'benmills/vimux'
    " Surround
    Plug 'tpope/vim-surround'
    " Matchit- Extended '%' matching
    Plug 'adelarsq/vim-matchit'
    " Git wrapper
    Plug 'tpope/vim-fugitive'
    Plug 'jiangmiao/auto-pairs'
    " Comment
    Plug 'tpope/vim-commentary'
    Plug 'skywind3000/asyncrun.vim'
    if has('nvim')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'jackguo380/vim-lsp-cxx-highlight'
        Plug 'dense-analysis/ale'
        let g:ale_linters_explicit = 1
        let g:ale_linters = { 'cpp': ['clangtidy'], 'c': ['clangtidy'], }
        let g:ale_fixers = { 'cpp': ['clangtidy'], 'c': ['clangtidy'], }
        " for showing in the statusline the name of function where the cursor resides
        Plug 'liuchengxu/vista.vim'
        " python highlight
        Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    endif
    "Plug 'plasticboy/vim-markdown'
call plug#end()
"}}}

"General {{{
    let mapleader = " "

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

    " Folding
    autocmd FileType vim
        \ setlocal foldlevel=0  foldmethod=marker foldmarker={{{,}}}
    autocmd FileType python
        \ setlocal foldlevel=99  foldmethod=indent


    " Miscs
    set wildmenu   "vim buildin command line completion

    " Mouse
"    if has('mouse')
"      set mouse=a
"    endif

    " Clipboard
    if !(has("nvim"))
      set clipboard=exclude:.* "disable system clibpard
    endif

    if has('autocmd')
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
        " highlight cursor nr only
        if !(has("nvim"))
            set cursorline
            augroup HiCursorNrOnly
                autocmd!
                autocmd ColorScheme * highlight clear CursorLine
            augroup END
        endif
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

        " display color values
        let g:Hexokinase_highlighters = ['background']
        let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'json']
        "}}}

    "StatusLine {{{
        set laststatus=2 "always display the status line
        set noshowmode

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
            \ 'colorscheme': 'jellybeans',
            \ 'active': {
            \     'left': [ [ 'mode', 'paste' ],
            \               [ 'readonly', 'filename', 'modified', 'method' ] ]
            \ },
            \ 'component_function': {
            \     'filename': 'LightlineFilename',
            \     'method': 'NearestMethodOrFunction'
            \ }
          \ }
        function! LightlineFilename()
          let root = fnamemodify(get(b:, 'git_dir'), ':h')
          let path = expand('%:p')
          if path[:len(root)-1] ==# root
            return path[len(root)+1:]
          endif
          return expand('%')
        endfunction
        function! NearestMethodOrFunction() abort
          return get(b:, 'vista_nearest_method_or_function', '')
        endfunction
        autocmd FileType cpp,c,cs,java,javascript,lisp  call vista#RunForNearestMethodOrFunction()
        let g:vista_default_executive = 'coc'
    "}}}

    "SignColumn {{{
        "cmd - ToggleSignColum, ToggleSignAndNumber
        if exists("&signcolumn")
            function! Toggle_SignColumn()
                if &signcolumn == 'yes' || &signcolumn == 'auto'
                    let &signcolumn='no'
                else
                    let &signcolumn='yes'
                endif
            endfunction
            command! -nargs=0 ToggleSignColumn call Toggle_SignColumn()

            function! Toggle_NS()
              if &signcolumn == 'yes' || &signcolumn == 'auto' || &number == 1 || &relativenumber == 1
                let &number=0
                let &relativenumber=0
                let &signcolumn='no'
              else
                let &number=1
                let &relativenumber=1
                let &signcolumn='yes'
              endif
            endfunction
            command! -nargs=0 ToggleSignAndNumber call Toggle_NS()
        endif

        let g:signify_vcs_list = [ 'git', 'hg' ]
        autocmd ColorScheme *
                  \ highlight clear SignColumn |
                  \ highlight SignifySignAdd    term=bold ctermbg=none  ctermfg=green |
                  \ highlight SignifySignDelete term=bold ctermbg=none  ctermfg=red   |
                  \ highlight SignifySignChange term=bold ctermbg=none  ctermfg=yellow
    "}}}
"}}}

"FileExplorer {{{
"}}}


"FuzzyFinder {{{
    "noremap <leader>fr :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
    "noremap <leader>bb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
    "noremap <leader>sb :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
    let g:Lf_ShortcutF = '<leader><leader>'  " find file
    let g:Lf_ShortcutB = '<leader>,'  " Alt+P  - opened files
    let g:Lf_CommandMap = {'<C-K>': ['<C-P>'], '<C-J>': ['<C-N>']}
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
    let g:Lf_ShowDevIcons = 0
    let g:Lf_GtagsAutoGenerate = 0
"}}}


"Mappings {{{
    " toggle quickfix window
    nnoremap <F8> :call asyncrun#quickfix_toggle(6)<cr>
    " toggle paste mode
    "noremap <F9> :set paste!<cr>
    " toggle sign column
    "map <Leader>ts :ToggleSignAndNumber<CR>
    " Reload .vimrc
    nnoremap <Leader>R :source $MYVIMRC<CR>
	" jump to the previous function
	nnoremap <silent> [f :call
	\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
	" jump to the next function
	nnoremap <silent> ]f :call
	\ search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>
    " Open .vimrc
    nnoremap <Leader>fp :edit ~/.vimrc<CR>
    " split window
    "map <Leader>w- :split<CR>
    "map <Leader>w. :vsplit<CR>
    " toggle maximized window and resized windows
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
    "nnoremap <Leader>wf :call <SID>ToggleResize()<CR>
    command! -nargs=0 ToggleFull call <SID>ToggleResize()

    " Map leader to which_key
    nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
    vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
    " Create map to add keys to
    let g:which_key_map =  {}
    " Define a separator
    let g:which_key_sep = '→'
    let g:which_key_use_floating_win = 0
    " colors
    highlight default link WhichKey          Operator
    highlight default link WhichKeySeperator DiffAdded
    highlight default link WhichKeyGroup     Identifier
    highlight default link WhichKeyDesc      Function

    let g:which_key_map[','] = [ ':LeaderfBuffer'            , 'switch buffer' ]
    let g:which_key_map['.'] = [ ':LeaderfFileCwd'           , 'find file' ]
    " re-define <Leader>. to workaround the issue with which-key
    nnoremap <Leader>. :LeaderfFileCwd<CR>
    nnoremap <Leader>' :<C-u>Leaderf --recall<CR>
    let g:which_key_map.f = {
        \ 'name': '+file',
        \ 'r': [':LeaderfMru', 'Leaderf-recent_files'],
        \ }
    let g:which_key_map.b = {
        \ 'name': '+buffer',
        \ 'b': [':LeaderfBuffer', 'Leaderf-buffers'],
        \ 'd': ['bd', 'delete-buffer'],
        \ }
    let g:which_key_map.w = {
        \ 'name': '+window',
        \ '-': [':split', 'split'],
        \ '.': [':vsplit', 'vsplit'],
        \ 'c': [':close', 'close'],
        \ 'o': [':only', 'close-all-other'],
        \ 'f': [':ToggleFull', 'toggle maximized'],
        \ }
    let g:which_key_map.s = {
        \ 'name': '+search',
        \ 'b': [':LeaderfLine', 'Leaderf-search_in_buffer'],
        \ 'i': [':CocList outline', 'jump to symbol'],
        \ 's': [':CocList -I symbols', 'search symbol in workspace'],
        \ }
    noremap <Leader>sp :<C-U><C-R>=printf("Leaderf rg -e %s", "")<CR>
    noremap <Leader>*  :<C-U><C-R>=printf("Leaderf rg -e %s", expand("<cword>"))<CR><CR>
    let g:which_key_map.t = {
        \ 'name': '+toggle',
        \ 'l': [':ToggleSignAndNumber', 'sign and number'],
        \ 'p': [':set paste!',          'paste mode'],
        \ }
    let g:which_key_map.c = {
        \ 'name': '+code',
        \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
        \ 'x' : [':CocList diagnostics'                , 'list errors'],
        \ }
    let g:which_key_map.l = {
        \ 'name': '+lsp',
        \ '.' : [':CocConfig'                          , 'config'],
        \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
        \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
        \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
        \ 'x' : [':CocList diagnostics'                , 'list errors'],
        \ }
    let g:which_key_map.o = {
        \ 'name': '+open',
        \ 't' : [':VimuxPromptCommand'                 , 'tmux prompt'],
        \ }
    call which_key#register('<Space>', "g:which_key_map")
    command! -bar -nargs=0 LeaderfFileCwd LeaderfFile %:p:h

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
        let g:tmux_navigator_no_mappings = 1
        nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
        nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
        nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
        nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
        nnoremap <silent> <M-r> :TmuxNavigatePrevious<cr>
        let g:tmux_resizer_no_mappings = 1
        nnoremap <silent> <M-H> :TmuxResizeLeft<cr>
        nnoremap <silent> <M-J> :TmuxResizeDown<cr>
        nnoremap <silent> <M-K> :TmuxResizeUp<cr>
        nnoremap <silent> <M-L> :TmuxResizeRight<cr>
        "map <Leader>vp :VimuxPromptCommand<cr>
    "}}}
"}}}

"GeneralFunctionality {{{
    " auto-pairs {{{
        let g:AutoPairsCenterLine = 0
    "}}}
    "AsyncRun {{{
        let g:asyncrun_open = 6
        let g:asyncrun_bell = 1
    "}}}
"}}}

"LanguageSpecificConfiguration {{{
    "CodeFormatter {{{
        "Uncrustify cmd - Uncrustify {{
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

            function! DoUncrustify(language)
              call Preserve(':silent %!uncrustify'
                  \ . ' -q '
                  \ . ' -l ' . a:language
                  \ . ' -c ' . g:uncrustify_cfg_file_path)
            endfunction
            function! Uncrustify()
                let exts = {"cpp": "cpp", "c": "c"}
                let ext = expand('%:e')
                if has_key(exts, ext)
                    call DoUncrustify(ext)
                endif
            endfunction
            command! Uncrustify call Uncrustify()
        "}}}
    "}}}
    "CTags {{{
        set tags=./.tags;,.tags  " upward search .tags from the dir of the file being edit, if not found, search .tags in `pwd`
        "Plug 'ludovicchabant/vim-gutentags' " disabled by default
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
    if (has("nvim"))
    "LSP  {{{

        " lsp TextEdit might fail if hidden is not set.
        set hidden

        " Some servers have issues with backup files, see #649
        set nobackup
        set nowritebackup

        " Give more space for displaying messages.
        set cmdheight=2

        " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
        " delays and poor user experience.
        set updatetime=300

        " Don't pass messages to |ins-completion-menu|.
        set shortmess+=c

        " Always show the signcolumn, otherwise it would shift the text each time
        " diagnostics appear/become resolved.
        set signcolumn=yes

        " hi
        "autocmd ColorScheme *
        "                      \ highlight Pmenu ctermfg=white ctermbg=0 |
        "                      \ highlight CocFloating ctermfg=white ctermbg=0
        autocmd ColorScheme *
            \ highlight default link CocHighlightText PmenuSbar

        let g:coc_global_extensions = [
          \ 'coc-json',
          \ 'coc-vimlsp',
          \ 'coc-sh',
          \ 'coc-cmake',
          \ 'coc-snippets',
          \ 'coc-python'
          \ ]

        " Use tab for trigger completion with characters ahead and navigate.
        " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        if has('patch8.1.1068')
          " Use `complete_info` if your (Neo)Vim version supports it.
          inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
          imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        " Use `[e` and `]e` to navigate diagnostics
        nmap <silent> [e <Plug>(coc-diagnostic-prev)
        nmap <silent> ]e <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gD <Plug>(coc-references)
        nnoremap <silent>K :call <SID>show_documentation()<CR>
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)

        nnoremap <leader>ck :call <SID>show_documentation()<CR>

        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Formatting selected code.
        "xmap <leader>f  <Plug>(coc-format-selected)
        "nmap <leader>f  <Plug>(coc-format-selected)

        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Introduce function text object
        " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)

        " Use <TAB> for selections ranges.
        " NOTE: Requires 'textDocument/selectionRange' support from the language server.
        " coc-tsserver, coc-python are the examples of servers that support it.
        "nmap <silent> <TAB> <Plug>(coc-range-select)
        "xmap <silent> <TAB> <Plug>(coc-range-select)

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocAction('format')

        " Add `:Fold` command to fold current buffer.
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " Add `:OR` command for organize imports of the current buffer.
        command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

        " Add (Neo)Vim's native statusline support.
        " NOTE: Please see `:h coc-status` for integrations with external plugins that
        " provide custom statusline: lightline.vim, vim-airline.
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

        " Resume latest coc list
        nnoremap <silent> <space>"  :<C-u>CocListResume<CR>
        au CursorHold * sil call CocActionAsync('highlight')
        au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
        " coc-snippets {{
            inoremap <silent><expr> <TAB>
              \ pumvisible() ? coc#_select_confirm() :
              \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()

            function! s:check_back_space() abort
              let col = col('.') - 1
              return !col || getline('.')[col - 1]  =~# '\s'
            endfunction

            let g:coc_snippet_next = '<tab>'
        "}}
    "}}}
    endif
"}}}

"Finalsetup {{{
  if has('gui_running')
      set background=light
  else
      set background=dark
  endif
  syntax enable
  "colorscheme dim
  colorscheme onedark
  "colorscheme gruvbox
"}}}
