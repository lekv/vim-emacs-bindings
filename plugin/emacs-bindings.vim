" Simple navigation and editing key bindings from emacs, for Vim.
" Inspired by a much more comprehensive plugin: Vimacs, by Andre Pang.

" TODO
"   command mode: <C-k> and <M-d> should not open command window
"

function! s:home()
  let start_col = col('.')
  normal! ^
  if col('.') == start_col
    normal! 0
  endif
  return ''
endfunction

function! s:kill_line()
  let [text_before_cursor, text_after_cursor] = s:split_line_text_at_cursor()
  if len(text_after_cursor) == 0
    normal! J
  else
    call setline(line('.'), text_before_cursor)
  endif
  return ''
endfunction

function! s:split_line_text_at_cursor()
  let line_text = getline(line('.'))
  let text_after_cursor  = line_text[col('.')-1 :]
  let text_before_cursor = (col('.') > 1) ? line_text[: col('.')-2] : ''
  return [text_before_cursor, text_after_cursor]
endfunction

nnoremap <Plug>emacs_up   gk
nnoremap <Plug>emacs_down gj
inoremap <expr> <Plug>emacs_up   pumvisible() ? "\<C-p>" : "\<C-o>gk"
inoremap <expr> <Plug>emacs_down pumvisible() ? "\<C-n>" : "\<C-o>gj"
inoremap <silent> <Plug>emacs_home <C-r>=<SID>home()<CR>
noremap  <silent> <Plug>emacs_home :call <SID>home()<CR>
inoremap <silent> <Plug>emacs_kill_line <C-r>=<SID>kill_line()<CR>
inoremap <silent> <Plug>emacs_delete_word_forwards <C-o>de
inoremap <silent> <Plug>emacs_delete_word_backwards <Space><Left><C-o>db<Del>

" on macvim, use option as meta key
if has("gui_macvim")
  set macmeta
endif

" normal mode
"  - navigation
map <C-p> <Plug>emacs_up
map <C-n> <Plug>emacs_down
map <C-b> h
map <C-f> l
map <C-a> <Plug>emacs_home
map <C-e> $
map <M-b> b
map <M-f> e
map <M-a> {
map <M-e> }

" insert mode
"  - navigation
imap <C-p> <Plug>emacs_up
imap <C-n> <Plug>emacs_down
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <Plug>emacs_home
imap <C-e> <End>
imap <M-b> <C-o>b
imap <M-f> <C-o>e<Right>
imap <M-a> <C-o>{
imap <M-e> <C-o>}
"  - editing
imap <C-d> <Del>
imap <C-h> <BS>
imap <M-d> <Plug>emacs_delete_word_forwards
imap <M-h> <Plug>emacs_delete_word_backwards
imap <C-k> <Plug>emacs_kill_line

" command line mode
"  - navigation
cmap <C-p> <Up>
cmap <C-n> <Down>
cmap <C-b> <Left>
cmap <C-f> <Right>
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <M-f> <S-Right>
cmap <M-b> <S-Left>
cmap <M-a> <Home>
cmap <M-e> <End>
"  - editing
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <M-h> <C-w>
cnoremap <M-d> <C-f>dwl<C-c>
cnoremap <C-k> <C-f>D<C-c><End>

" command-T window
let g:CommandTCursorLeftMap  = ['<Left>',  '<C-b>']
let g:CommandTCursorRightMap = ['<Right>', '<C-f>']
let g:CommandTBackspaceMap   = ['<BS>',    '<C-h>']
let g:CommandTDeleteMap      = ['<Del>',   '<C-d>']

