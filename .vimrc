if has("win32") || has("win16")
  language mes en_US
  source $VIMRUNTIME/mswin.vim
  set langmenu=en_US.UTF-8
endif

set nocompatible               " be iMproved
filetype off                   " required!

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"Add your bundles here
"...All your other bundles...
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
" Setting up Vundle - the vim plugin bundler end

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

""original repos on github
Bundle 'othree/html5.vim'
Bundle 'othree/html5-syntax.vim'
Bundle 'othree/eregex.vim'
Bundle 'honza/vim-snippets'
Bundle 'othree/vim-autocomplpop'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
Bundle 'tpope/vim-fugitive'
""on vim.org
Bundle 'L9'
Bundle 'junegunn/seoul256.vim'

" initialize for common setup
let mapleader = "\<tab>"
filetype plugin on
syntax on
set t_Co=256
set background=dark
let g:seoul256_background = 233
colorscheme seoul256

set backspace=indent,eol,start
set hlsearch
set ignorecase
set smartcase
set ruler
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set fileencodings=utf-8,big5,default
set encoding=utf8
set ff=unix
set pastetoggle=<F2>

" syntax highlighting borrow from http://drupal.org/node/29325
if has("autocmd")
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END

  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
endif

" tab key
nnoremap <C-t> :tabnew<CR>
nnoremap <leader>[ :tabprevious<CR>
nnoremap <leader>] :tabnext<CR>
nnoremap <leader>t :tabnext<CR>
inoremap <C-t> <Esc>:tabnew<CR>
inoremap <leader>[ <Esc>:tabprevious<CR>i
inoremap <leader>] <Esc>:tabnext<CR>i
inoremap <leader>t <Esc>:tabnext<CR>

" close bracket, return a corresponding paren to be sent to the buffer
function! CloseParen()
    let parenpairs = {'(' : ')',
                   \  '[' : ']',
                   \  '{' : '}'}

    let [m_lnum, m_col] = searchpairpos('[[({]', '', '[\])}]', 'nbW')

    if (m_lnum != 0) && (m_col != 0)
        let c = getline(m_lnum)[m_col - 1]
        return parenpairs[c]
    endif
    return ''
endfun
inoremap <C-c> <C-r>=CloseParen()<CR>

" omnifunc
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving insert mode
inoremap <leader><tab> <C-x><C-o>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" airline
set laststatus=2
let g:airline_detect_paste=1
let g:airline_powerline_fonts=0
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_paste_symbol = '∥'
let g:airline_whitespace_symbol = 'Ξ'
let g:airline_enable_branch = 1
let g:airline_enable_hunks = 1

" Work-around incomplete terminfo databases                                     
" Particulalry useful when under `screen`, which may or may not be attached to  
" a physical terminal capable of 256color mode.                                 
if match($TERMCAP, 'Co#256:') == 0 || match($TERMCAP, ':Co#256:') > 0           
  set t_Co=256                                                                
endif 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Directory path
"Set working directory to the current file
"http://vim.wikia.com/wiki/VimTip64
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * lcd %:p:h
