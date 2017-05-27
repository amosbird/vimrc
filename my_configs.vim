set guifont=Consolas:h10
set guifontwide=黑体:h10


map <C-Tab> gt
map <C-S-Tab> gT
map <silent> <C-w> :bd<CR>

map <silent> <leader>bb :CtrlPBuffer<CR>
map <silent> <leader>f :CtrlPMRU<CR>
map <silent> <leader>j :CtrlPMixed<CR>

inoremap        <C-K> <C-O>D


set clipboard=unnamed

if has("gui_running")
  set columns=140
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
nmap <leader>; <Plug>CommentaryLine

autocmd BufEnter * silent! lcd %:p:h
autocmd FileType apache setlocal commentstring=#\ %s

set timeoutlen=1000 ttimeoutlen=100

noremap ,c ZZ
noremap ,k ZQ
