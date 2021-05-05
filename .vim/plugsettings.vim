" Automatically install plug if it's not there
" Install CoC plugins at next launch if user has nvim
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter *
        \ PlugInstall --sync | UpdateRemotePlugins | bd | source $MYVIMRC
endif

" Automatically install missing plugins on startup
autocmd VimEnter *
    \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \ | PlugInstall --sync
        \ | q
    \ | endif

" Start plugin list-querry
call plug#begin('$HOME/.vim/plugged')

if has ('nvim')
    Plug 'preservim/nerdcommenter'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
        \ 'coc-actions',
        \ 'coc-discord-neovim',
        \ 'coc-fish',
        \ 'coc-format-json',
        \ 'coc-git',
        \ 'coc-json',
        \ 'coc-markdownlint',
        \ 'coc-marketplace',
        \ 'coc-pairs',
        \ 'coc-sh',
        \ 'coc-tabnine',
        \ 'coc-vimlsp',
        \ 'coc-pyright',
    \ ]
    "\ 'coc-fzf-preview',
    "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
else
    Plug 'ycm-core/YouCompleteMe', {'do': './install.py --all --clangd-completer'}
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'jiangmiao/auto-pairs'
    Plug 'rhysd/vim-clang-format'
endif
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'SirVer/ultisnips'
Plug 'Yohannfra/Nvim-Switch-Buffer'
Plug 'aperezdc/vim-template'
Plug 'brooth/far.vim'
Plug 'dag/vim-fish'
Plug 'idanarye/vim-vebugger'
Plug 'majutsushi/tagbar'
Plug 'nanotech/jellybeans.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/Gummybears'

" End plugin list
call plug#end()
