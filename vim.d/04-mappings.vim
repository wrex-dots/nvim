"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinds will be presented as such:                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MODES: Mappings' purpose
"
" <Keystroke>[<Additional keystrokes>...] [=> Action]
"
" [Optional complementary information]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: If a keybind uses Alt but you're on Mac, you can     "
" execute it by using Command instead of Alt.                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mapleader
"
" Enables extra key combinations, like <leader>w to save
"
" Note: Keybinds using <leader> need to be done in
" quick succession, while most other do not care about how
" fast or slow you perform them.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL: How to exit vim
"
" <Ctrl+W><Q>       => Exit only if no buffer has unsaved changes
" <Ctrl+W><X>       => Save all changes and exit
" <Ctrl+W><Shift+Q> => Exits no matter what (risky)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-W>q  :qa<cr>
map <C-W>x  :xa<cr>
map <C-W>qq :qa!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL: Fast saving
"
" <leader><W>       => Save buffer (only if modified)
" <leader><Shift+W> => Force save buffer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>w :up<cr>
nmap <leader>W :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL: Manage tabs
"
" <leader><T><N> => New tab
" <leader><T><C> => Close current tab
" <leader><T><O> => Close all but current tab
" <leader><T><M> => Move a tab (requires manual completion)
" <Ctrl+PgUp>    => Go to previous buffer
" <Ctrl+PgDown>  => Go to next buffer
" <leader><T><L> => Go to last accessed tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>tn :tabnew<cr>
nmap <leader>to :tabonly<cr>
nmap <leader>tc :tabclose<cr>
nmap <leader>tm :tabmove
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
nmap <C-PageUp>   :tabprevious<cr>
nmap <C-PageDown> :tabnext<cr>

let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL: Set CWD to the directory of the open buffer
"
" <leader><C><D>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>cd :cd %:p:h<cr>:pwd<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL: Disable last search highlights
"
" <leader><Enter>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader><cr> :noh<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL VISUAL: Move lines of text up or down
"
" <Alt+↑> => Move a line up
" <Alt+↓> => Move a line down
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
else
  nmap <M-Up> mz:m-2<cr>`z
  nmap <M-Down> mz:m+<cr>`z
  vmap <M-Up> :m'<-2<cr>`>my`<mzgv`yo`z
  vmap <M-Down> :m'>+<cr>`<my`>mzgv`yo`z
endif

" Fast saving
nmap <leader>w :up<cr>
nmap <leader>W :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL: Sort selection
"
" <Alt+S>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("mac") || has("macunix")
  vmap <D-s> :sort<cr>
else
  vmap <M-s> :sort<cr>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL: Spell checking
"
" <leader><s><s> => Toggle spellcheck on/off
" <leader><s><n> => Next spelling error
" <leader><s><n> => Previous spelling error
" <leader><s><a> => Add to current locale's custom dictionary
" <leader><s><?> => Show a list of potential fixes for current
"                   spelling error
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL: Remove Windows' annoying EOL ^M character in buffer
"
" <leader><M>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
