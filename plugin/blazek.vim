" blazek.vim - Blazek customizations
" Maintainer:   Chris Blazek <chris.blazek@gmail.com>

if exists("g:loaded_blazek") || &cp
    finish
endif
let g:loaded_blazek = 1

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

