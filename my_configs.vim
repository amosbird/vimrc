set guifont=Consolas:h10
set guifontwide=黑体:h10
set guicursor+=a:blinkon0

map <C-Tab> gt
map <C-S-Tab> gT
map <silent> <C-w> :bd<CR>

map <silent> <leader>b :Denite buffer -winheight=`40*winheight(0)/100`<CR>
map <silent> <leader>f :Denite file_old -winheight=`40*winheight(0)/100`<CR>
map <silent> <C-s> :Denite line -auto-highlight -winheight=`40*winheight(0)/100`<CR>
map <silent> <leader>j :CtrlPMixed<CR>

inoremap <C-K> <C-O>D


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

set timeoutlen=1000 ttimeoutlen=10

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
cnoremap <esc>k <c-f>C<c-c>

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
call denite#custom#map(
      \ 'insert',
      \ '<C-g>',
      \ '<denite:quit>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-v>',
      \ '<denite:scroll_window_downwards>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<esc>v',
      \ '<denite:scroll_window_upwards>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-i>',
      \ '<denite:do_action:preview>',
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

call textobj#user#plugin('anyblock', {
    \ '-' : {
    \      'select-a' : 'aj', '*select-a-function*' : 'textobj#anyblock#select_a',
    \      'select-i' : 'ij', '*select-i-function*' : 'textobj#anyblock#select_i',
    \   },
    \ })


let g:max_osc52_sequence=100000

" Send a string to the terminal's clipboard using the OSC 52 sequence.
function! SendViaOSC52 (str)
  if match($TERM, 'tmux') > -1
    let osc52 = s:get_OSC52_TMUX(a:str)
  else
    let osc52 = s:get_OSC52(a:str)
  endif

  let len = strlen(osc52)
  if len < g:max_osc52_sequence
    call s:rawecho(osc52)
  else
    echo "Selection too long to send to terminal: " . len
  endif
endfunction

" This function base64's the entire string and wraps it in a single OSC52.
"
" It's appropriate when running in a raw terminal that supports OSC 52.
function! s:get_OSC52 (str)
  let b64 = s:b64encode(a:str)
  let rv = "\e]52;c;" . b64 . "\x07"
  return rv
endfunction

function! s:get_OSC52_TMUX (str)
  let b64 = s:b64encode(a:str)
  let b64 = "\ePtmux;\e\e]52;c;" . b64 . "\e\\"
  return b64
endfunction

" Echo a string to the terminal without munging the escape sequences.
"
" This function causes the terminal to flash as a side effect.  It would be
" better if it didn't, but I can't figure out how.
function! s:rawecho (str)
  exec("silent! !echo " . shellescape(a:str))
  redraw!
endfunction

" Lookup table for s:b64encode.
let s:b64_table = [
      \ "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
      \ "Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f",
      \ "g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v",
      \ "w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/"]

" Encode a string of bytes in base 64.
" Copied from http://vim-soko.googlecode.com/svn-history/r405/trunk/vimfiles/
" autoload/base64.vim
function! s:b64encode(str)
  let bytes = s:str2bytes(a:str)
  let b64 = []

  for i in range(0, len(bytes) - 1, 3)
    let n = bytes[i] * 0x10000
          \ + get(bytes, i + 1, 0) * 0x100
          \ + get(bytes, i + 2, 0)
    call add(b64, s:b64_table[n / 0x40000])
    call add(b64, s:b64_table[n / 0x1000 % 0x40])
    call add(b64, s:b64_table[n / 0x40 % 0x40])
    call add(b64, s:b64_table[n % 0x40])
  endfor

  if len(bytes) % 3 == 1
    let b64[-1] = '='
    let b64[-2] = '='
  endif

  if len(bytes) % 3 == 2
    let b64[-1] = '='
  endif

  return join(b64, '')

endfunction

function! s:str2bytes(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction
