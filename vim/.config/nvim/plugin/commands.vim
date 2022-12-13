" trim trailing whitespace
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

" Toggle sign and line number
function! Toggle_SignAndNumber()
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
command! -nargs=0 ToggleSignAndNumber call Toggle_SignAndNumber()

" Toggle line number
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

" Toggle sign
function! Toggle_SignColumn()
    if &signcolumn == 'yes' || &signcolumn == 'auto'
        let &signcolumn='no'
    else
        let &signcolumn='yes'
    endif
endfunction
command! -nargs=0 ToggleSignColumn call Toggle_SignColumn()

" toggle maximized/resized windows
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
command! -nargs=0 ToggleFull call <SID>ToggleResize()

" format selected range
command! -nargs=0 FormatRange lua vim.lsp.buf.range_formatting()
vnoremap <silent> <leader>lf :<C-U>FormatRange<cr>

" jsonc for some vscode setting json files
autocmd BufNewFile,BufRead devcontainer.json setlocal filetype=jsonc
autocmd BufNewFile,BufRead cmake-variants.json setlocal filetype=jsonc
