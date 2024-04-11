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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set theme depending on wether you're using term or TTY
"
" That way, if you're mad and code in TTY, things will look
" *approximately* good.
" But you will likely prefer a normal terminal's 256 colours.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if &term == "linux"
"     let g:jellybeans_overrides = {
"                 \'background': { 'ctermbg': 'none', '256ctermbg': 'black' },
"                 \}
"     let g:jellybeans_use_term_italics = 1
"     let g:jellybeans_use_lowcolor_black = 1
"     colo jellybeans
" else
"     " Enable full colour range support
"     set termguicolors
"
"     " Change this to your favourite theme
"     colo carbonfox
"
"     " Make window separators more elegant/discrete
"     hi! link CocFloatDividingLine WinSeparator
"
"     " Improve contrast in pop-up menus
"     hi! link CocMenuSel PmenuSel
" endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Higlight characters that exceed a certain column limit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9

"  80: C and C++
autocmd BufEnter,FileType *.c,*.cpp,*.h,*.hpp match OverLength /\%>80v.\+/
" 124: Makefiles
autocmd BufEnter,FileType Makefile,makefile,*.mk,*.mak match OverLength /\%>124v.\+/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enable syntax highlighting for standard formats that use
"    a different extension
"
" A good example is Rofi's `.rasi` config format which is a
" custom CSS format.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .rasi -> .css
" I wouldn't recommend that one with this config, though, as
" by default it replaces double quotes with single quotes in
" CSS on save and that breaks Rofi's config.
" au BufEnter,FileType *.rasi setf css
