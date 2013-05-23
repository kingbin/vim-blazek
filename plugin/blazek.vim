" ---------------------------------------------------------------------------
" blazek.vim - Blazek customizations
" Language:    Functions for my personal use
" Maintainer:  Chris Blazek <chris.blazek@gmail.com>
" URL:
" License:     GPL V3

if exists("g:vim_blazek")
  finish
endif

let g:vim_blazek = 1

"map up/down arrow keys to unimpaired commands
nmap <Up> [e
nmap <Down> ]e
vmap <Up> [egv
vmap <Down> ]egv

"map left/right arrow keys to indendation
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv

" Highlight end of line space red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()


"execute pathogen#infect()
syntax on
filetype plugin indent on


function! s:ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! s:TrimSpaces() range
  let oldhlsearch=s:ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

command! -bar -nargs=? ShowSpaces call <SID>ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call <SID>TrimSpaces()
nnoremap <F12>     <SID>ShowSpaces 1<CR>
" nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   <SID>TrimSpaces<CR>


" Run :FixWhitespace to remove end of line white space.
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)


" Gist Settings por favor
let g:gist_clip_command = 'putclip' "cygwin copy gist code with '-c' option
let g:gist_detect_filetype = 1 "capt obvious
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'chrome %URL% &'
"let g:gist_show_privates = 1 "show private gists with -l
let g:gist_post_private = 1 " gists private by default


"autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l/%L,%c%V%)\ %P

