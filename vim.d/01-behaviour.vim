"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enable loading local .vimrc files
"
" Allows for per-project configuration
" See https://medium.com/@dnrvs/per-project-settings-in-nvim-fc8c8877d970
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set exrc
set secure


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enhance compatibility (for Fish users)
"
" Fish is AWESOME! But it's not POSIX compliant. 😔
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &shell =~# 'fish$'
    set shell=sh
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set how many lines of history VIM has to remember
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enable mouse support in all modes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
    set mouse=a
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Detect automatically is changed from the outside
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"
" Turn backup off, since most stuff is in SVN, git etc anyway.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fix Vim's weird PgUp / PgDown scrolling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <PageUp> <C-U>
vnoremap <silent> <PageUp> <C-U>
inoremap <silent> <PageUp> <C-\><C-O><C-U>

nnoremap <silent> <PageDown> <C-D>
vnoremap <silent> <PageDown> <C-D>
inoremap <silent> <PageDown> <C-\><C-O><C-D>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Improve buffer switching mechanics
"
" useopen: If a window has the buffer open, go there
" usetab:  Like `useopen`, but consider all tabs
" split:   When opening a buffer for a quickfix, split the
"          current window
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
  set switchbuf=useopen,usetab,split
  set stal=2
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Return to last edit position when opening files
"
" Saves a lot of time scrolling when you reopen something!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufReadPost *
   \ if line("'\"") > 1 && line("'\"") <= line("$")
     \ | exe "normal! g'\""
   \ | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Delete trailing white space characters on save
"
" Call :WhiteSpaceCleanup to trigger it manually (ignoring exclusions)
" Edit s:NoWhiteSpaceCleanup to add exceptions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Exception list
let s:NoWhiteSpaceCleanup = [
  \ 'markdown',
  \ 'gitcommit',
\ ]

" Function that will do the job
fun! CleanExtraSpaces(force)
    if index(s:NoWhiteSpaceCleanup, &ft) != -1 && a:force != v:true
      return
    endif

    let save_cursor = getpos(".")
    let old_query = getreg('/')

    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Make it an editor command
command WhiteSpaceCleanup :call CleanExtraSpaces(v:true)

" Make it automatic
autocmd BufWritePre * :call CleanExtraSpaces(v:false)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Use % to jump to match `<` `>` symbols in languages that
"    use them
"
" You can normally use % to jump to matching `[` `]` or `(` `)`
" etc, as well as `if` `elseif` `endif` etc (see :h matchit).
" But this feature doesn't support `<` `>` by default.
" Add filetypes here to expand this functionality to other
" languages.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup AngleBrackets
  autocmd!
  autocmd FileType cpp,typescript,javascriptreact,typescriptreact
          \ set matchpairs+=<:>
augroup END

" Keep at least 4 lines of context above the cursor
set so=4

" Avoid garbled characters in Chinese language Windows OS
"
" Although if you use Windows you're a monster.
" Also, I can't read Chinese.
let $LANG='en'
set langmenu=en

" Turn on the Wild menu
"
" It's the little completion pop-up you get when using <Tab>
" in command mode. 😉
set wildmenu

" Ignore some stuff in Wild menu by default
"
" Completion will still be available if you start typing out
" ignored files/dirs' names.
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Display, in the status bar, your current position in the buffer
set ruler
set rulerformat=%l,%c%V%=%P

" Hide a buffer when it is abandoned
set hid

" Configure backspace so it acts as it should
"
" Another piece of config I forgot what it does.
" Judging by the comment, I'm not willing to try without.
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
"
" Only for users with at least 200 IQ.
set smartcase

" Highlight search results
set hlsearch

" When searching, instantly jump to first match as you type
set incsearch

" Don't redraw while executing macros
"
" Good for performance, will wait until macro is fully executed to
" redraw your buffer.
set lazyredraw

" For regular expressions turn magic on
"
" See `:h magic` for details.
" If you're like me, you'll still end up using `:s:\v`
" because RegExes rule!
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set tm=500
set t_vb=
" set novisualbell

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif
