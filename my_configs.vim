set guifont=Consolas:h10
set guifontwide=黑体:h10
set guicursor+=a:blinkon0

map <C-Tab> gt
map <C-S-Tab> gT
map <silent> <C-w> :bd<CR>

map <silent> <leader>bb :CtrlPBuffer<CR>
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



