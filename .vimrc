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
Bundle 'othree/vim-autocomplpop'
Bundle 'jimyhuang/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'pangloss/vim-javascript'
"Bundle 'nathanaelkane/vim-indent-guides'
"Bundle 'tsaleh/vim-matchit'
Bundle 'tpope/vim-surround'
"Bundle 'uguu-org/vim-matrix-screensaver'
"Bundle 'gkz/vim-ls'
Bundle 'digitaltoad/vim-jade'
Bundle 'mhinz/vim-signify'
Bundle 'majutsushi/tagbar'
" Bundle 'ervandew/supertab'

""colorscheme
" Bundle 'chriskempson/base16-vim'
Bundle 'nanotech/jellybeans.vim'
" Bundle 'junegunn/seoul256.vim'

""on https://github.com/vim-scripts/
Bundle 'L9'
Bundle 'jsbeautify'

" initialize for common setup
syntax on
filetype plugin on
set t_Co=256
set background=dark
colorscheme jellybeans
"let g:seoul256_background = 233

let mapleader = ','
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
set noerrorbells
set novisualbell
set ambiwidth=double
set wildmode=longest,list,full
set wildmenu

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
nnoremap <leader><tab> :tabnext<CR>
inoremap <leader><tab> :tabnext<CR>

" omnifunc
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving insert mode
inoremap <leader><tab> <C-x><C-o>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'Et'
nnoremap <F3> :CtrlPBuffer<CR>
nnoremap <F4> :CtrlP<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

" airline
set laststatus=2
let g:airline_detect_paste=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_theme='jellybeans'
"let g:airline_left_sep = '»'
"let g:airline_right_sep = '«'
"let g:airline_paste_symbol = '∥'
"let g:airline_whitespace_symbol = 'Ξ'

" Syntastic
let g:syntastic_php_checkers=['php']
let g:syntastic_php_phpcs_args='--report=csv --standard=Drupal --extensions=php,module,inc,install,test,profile,theme'
let g:syntastic_auto_jump=1
nnoremap <C-l> :SyntasticCheck<CR>
nnoremap <C-e> :Errors<CR>

" fix indent
" nnoremap <C-i> gg=G''

" remove unecessery whitespace when saving
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
" autocmd BufWritePre * :%s/\s\+$//e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Directory path
"Set working directory to the current file
"http://vim.wikia.com/wiki/VimTip64
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufEnter * lcd %:p:h

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omni menu colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hi Pmenu ctermbg=white
"hi PmenuSel ctermbg=yellow ctermfg=black

"hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
