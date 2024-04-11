"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enable filetype plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enable syntax highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enable 256 colors palette in Gnome Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra GUI mode options
"
" Terminal is superior anyway.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Use Unix as the standard file type when possible
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ffs=unix,dos,mac
