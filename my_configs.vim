set guifont=Consolas:h10
set guifontwide=黑体:h10
set guicursor+=a:blinkon0

map <C-Tab> gt
map <C-S-Tab> gT
map <silent> <C-w> :bd<CR>

map <silent> <leader>bb :Denite buffer<CR>
map <silent> <leader>f :CtrlPMRU<CR>
map <silent> <leader>j :CtrlPMixed<CR>

inoremap        <C-K> <C-O>D


set clipboard=unnamed

if has("gui_running")
  set columns=116
  set lines=56
  winpos 450 0
endif

vnoremap ig :<C-U>silent! normal! ggVG<CR>
omap af :normal Vig<CR>

let @o="mqYP`q"
nnoremap , @o

noremap - $
xmap s <Plug>VSurround
xnoremap S s
map <leader>; <Plug>Commentary
nmap <leader>;; <Plug>CommentaryLine

autocmd BufEnter * silent! lcd %:p:h
autocmd FileType apache setlocal commentstring=#\ %s

set timeoutlen=1000 ttimeoutlen=100

noremap ,, ZZ
noremap ,c ZZ
noremap ,k ZQ
nnoremap <silent> <Leader>sc :nohlsearch<CR><C-L>

map <silent> <C-h> :wincmd h<CR>
map <silent> <C-j> :wincmd j<CR>
map <silent> <C-k> :wincmd k<CR>
map <silent> <C-l> :wincmd l<CR>

map <silent> <Leader>gs :Gstatus<CR>
map <silent> <Leader>gb :Gblame<CR>
map <silent> <Leader>gf :Gfetch<CR>
map <silent> <Leader>gF :Gpull<CR>
map <silent> <Leader>gp :Gpush<CR>

silent! unmap <A-j>
silent! unmap <A-k>

cnoremap <C-k> <c-f>C<c-c>
cnoremap <A-k> <c-f>C<c-c>

" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

let &t_ti .= "\<Esc>[?2004h"
let &t_te .= "\<Esc>[?2004l"

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>

set noimdisable
