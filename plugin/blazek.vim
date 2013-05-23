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




"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l/%L,%c%V%)\ %P

:set nu

"hide buffers when not displayed
set hidden

let g:statline_fugitive = 1







""statusline setup
"set statusline =%#identifier#
"set statusline+=[%t]    "tail of the filename
"set statusline+=%*
"
""display a warning if fileformat isnt unix
"set statusline+=%#warningmsg#
"set statusline+=%{&ff!='unix'?'['.&ff.']':''}
"set statusline+=%*
"
""display a warning if file encoding isnt utf-8
"set statusline+=%#warningmsg#
"set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
"set statusline+=%*
"
"set statusline+=%h      "help file flag
"set statusline+=%y      "filetype
"
""read only flag
"set statusline+=%#identifier#
"set statusline+=%r
"set statusline+=%*
"
""modified flag
"set statusline+=%#identifier#
"set statusline+=%m
"set statusline+=%*
"
"set statusline+=%{fugitive#statusline()}
"
""display a warning if &et is wrong, or we have mixed-indenting
"set statusline+=%#error#
"set statusline+=%{StatuslineTabWarning()}
"set statusline+=%*
"
"set statusline+=%{StatuslineTrailingSpaceWarning()}
"
"set statusline+=%{StatuslineLongLineWarning()}
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
""display a warning if &paste is set
"set statusline+=%#error#
"set statusline+=%{&paste?'[paste]':''}
"set statusline+=%*
"
"set statusline+=%=      "left/right separator
"set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
"set statusline+=%c,     "cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file
"set laststatus=2
"
""recalculate the trailing whitespace warning when idle, and after saving
"autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
"
""return '[\s]' if trailing white space is detected
""return '' otherwise
"function! StatuslineTrailingSpaceWarning()
"    if !exists("b:statusline_trailing_space_warning")
"
"        if !&modifiable
"            let b:statusline_trailing_space_warning = ''
"            return b:statusline_trailing_space_warning
"        endif
"
"        if search('\s\+$', 'nw') != 0
"            let b:statusline_trailing_space_warning = '[\s]'
"        else
"            let b:statusline_trailing_space_warning = ''
"        endif
"    endif
"    return b:statusline_trailing_space_warning
"endfunction
"
"
""return the syntax highlight group under the cursor ''
"function! StatuslineCurrentHighlight()
"    let name = synIDattr(synID(line('.'),col('.'),1),'name')
"    if name == ''
"        return ''
"    else
"        return '[' . name . ']'
"    endif
"endfunction
"
""recalculate the tab warning flag when idle and after writing
"autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
"
""return '[&et]' if &et is set wrong
""return '[mixed-indenting]' if spaces and tabs are used to indent
""return an empty string if everything is fine
"function! StatuslineTabWarning()
"    if !exists("b:statusline_tab_warning")
"        let b:statusline_tab_warning = ''
"
"        if !&modifiable
"            return b:statusline_tab_warning
"        endif
"
"        let tabs = search('^\t', 'nw') != 0
"
"        "find spaces that arent used as alignment in the first indent column
"        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0
"
"        if tabs && spaces
"            let b:statusline_tab_warning =  '[mixed-indenting]'
"        elseif (spaces && !&et) || (tabs && &et)
"            let b:statusline_tab_warning = '[&et]'
"        endif
"    endif
"    return b:statusline_tab_warning
"endfunction
"
""recalculate the long line warning when idle and after saving
"autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning
"
""return a warning for "long lines" where "long" is either &textwidth or 80 (if
""no &textwidth is set)
""
""return '' if no long lines
""return '[#x,my,$z] if long lines are found, were x is the number of long
""lines, y is the median length of the long lines and z is the length of the
""longest line
"function! StatuslineLongLineWarning()
"    if !exists("b:statusline_long_line_warning")
"
"        if !&modifiable
"            let b:statusline_long_line_warning = ''
"            return b:statusline_long_line_warning
"        endif
"
"        let long_line_lens = s:LongLines()
"
"        if len(long_line_lens) > 0
"            let b:statusline_long_line_warning = "[" .
"                        \ '#' . len(long_line_lens) . "," .
"                        \ 'm' . s:Median(long_line_lens) . "," .
"                        \ '$' . max(long_line_lens) . "]"
"        else
"            let b:statusline_long_line_warning = ""
"        endif
"    endif
"    return b:statusline_long_line_warning
"endfunction
"
""return a list containing the lengths of the long lines in this buffer
"function! s:LongLines()
"    let threshold = (&tw ? &tw : 80)
"    let spaces = repeat(" ", &ts)
"    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
"    return filter(line_lens, 'v:val > threshold')
"endfunction
"
""find the median of the given array of numbers
"function! s:Median(nums)
"    let nums = sort(a:nums)
"    let l = len(nums)
"
"    if l % 2 == 1
"        let i = (l-1) / 2
"        return nums[i]
"    else
"        return (nums[l/2] + nums[(l/2)-1]) / 2
"    endif
"endfunction


set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim



