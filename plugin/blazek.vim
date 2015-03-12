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

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" Highlight end of line space red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\|\t/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=#382424
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|\t/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$\|\t/
"autocmd BufWinLeave * call clearmatches()

"match ExtraWhitespace /\s\+$\|\t/
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=#382424
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$|\t/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$|\t/
""autocmd BufWinLeave * call clearmatches()

"Spell checking toggle w ',s'
"let mapleader = ","
"nmap <silent> <leader>s :set spell!<CR>

"Spelling region:
"set spelllang=en_us

imap <Leader>s <C-o>:setlocal spell! spelllang=en_gb<CR>
nmap <Leader>s :setlocal spell! spelllang=en_gb<CR>


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


autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#111111
autocmd BufEnter * match OverLength /\%80v.*/



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


" sets the working directory to the current file's directory:
autocmd BufEnter * lcd %:p:h
" source: http://superuser.com/questions/195022/vim-how-to-synchronize-nerdtree-with-current-opened-tab-file-path



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDtree
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F1> :NERDTreeToggle<CR>
" open Nerd Tree in folder of file in active buffer
map <Leader>nt :NERDTree %:p:h<CR>
" source: http://stackoverflow.com/questions/5800840/nerdtree-load-particular-directory-automatically

" customize colours colors theme highlighting
" hi Directory guifg=#96CBFE guibg=#00ff00 ctermfg=red
" source: http://www.ur-ban.com/blog/2011/04/01/nerdtree-directory-colours/
" hi treeDir guifg=#ff0000 guibg=#00ff00 ctermfg=red

" let loaded_nerd_tree = 1
let NERDChristmasTree = 0

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', 'blue', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" source: https://github.com/scrooloose/nerdtree/issues/201#issuecomment-9954740





"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l/%L,%c%V%)\ %P

:set nu

"hide buffers when not displayed
set hidden

"let g:statline_fugitive = 1

"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"Syntastic setup
 let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': ['javascript','json','css','less','html','erlang','ruby','yaml','zsh'],
                               \ 'passive_filetypes': ['puppet'] }
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1
let g:syntastic_ignore_files=['.vim$']
if has('unix')
  let g:syntastic_error_symbol='✗'
  let g:syntastic_style_error_symbol='➤'
  let g:syntastic_warning_symbol='⚠'
  let g:syntastic_style_warning_symbol='➤'
else
  let g:syntastic_error_symbol='!'
  let g:syntastic_style_error_symbol='>'
  let g:syntastic_warning_symbol='.'
  let g:syntastic_style_warning_symbol='>'
endif

let g:syntastic_javascript_checkers=['jshint']

function s:find_jshintrc(dir)
    let l:found = globpath(a:dir, '.jshintrc')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_jshintrc(l:parent)
    endif

    return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_jshintrc(l:dir)
    let g:syntastic_javascript_jshint_args = '--config '.l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()
let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
let g:syntastic_debug = 0







set foldlevelstart=1
set foldmethod=syntax

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"set nofoldenable

au FileType javascript call JavaScriptFold()
let g:used_javascript_libs = 'underscore,angularjs,jasmine,handlebars'


"undo tree
nnoremap <F6> :UndotreeToggle<cr>

let g:undotree_WindowLayout = 3

" if set, let undotree window get focus after being opened, otherwise
" focus will stay in current window.
let g:undotree_SetFocusWhenToggle = 0

" Highlight changed text
let g:undotree_HighlightChangedText = 1






