if has("win32") || has("win16")
  language mes en_US
  source $VIMRUNTIME/mswin.vim
  set langmenu=en_US.UTF-8
endif

set nocompatible               " be iMproved
filetype off                   " required!

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Original repos on github
Plugin 'othree/html5.vim'
Plugin 'othree/html5-syntax.vim'
Plugin 'othree/eregex.vim'
Plugin 'othree/vim-autocomplpop'
Plugin 'jimyhuang/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'tsaleh/vim-matchit'
Plugin 'tpope/vim-surround'
"Plugin 'uguu-org/vim-matrix-screensaver'
"Plugin 'gkz/vim-ls'
Plugin 'digitaltoad/vim-jade'
Plugin 'mhinz/vim-signify'
Plugin 'majutsushi/tagbar'
"Plugin 'ervandew/supertab'

"colorscheme
"Plugin 'chriskempson/base16-vim'
Plugin 'nanotech/jellybeans.vim'
"Plugin 'junegunn/seoul256.vim'

""on https://github.com/vim-scripts/
Plugin 'L9'
Plugin 'jsbeautify'

call vundle#end()

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall!
endif

" initialize for common setup
syntax on
filetype plugin on
set t_Co=256
set background=dark
colorscheme jellybeans

let mapleader = ','
let g:mapleader = ","
set backspace=indent,eol,start
set incsearch
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
set wildmenu
set wildmode=list:longest,full
set keywordprg=":help"
set ttimeout
set ttimeoutlen=50

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
"inoremap <leader><tab> <C-x><C-o>
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
let g:airline_powerline_fonts=0
let g:airline_theme='jellybeans'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
"let g:airline_paste_symbol = '∥'
"let g:airline_whitespace_symbol = 'Ξ'

" Syntastic
let g:syntastic_php_checkers=['php']
let g:syntastic_php_phpcs_args='--report=csv --standard=Drupal --extensions=php,module,inc,install,test,profile,theme'
let g:syntastic_auto_jump=1
nnoremap <leader>ck :SyntasticCheck<CR>
nnoremap <leader>er :Errors<CR>

" fix indent
" nnoremap <C-i> gg=G''

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
nnoremap <leader>x :%s/\s\+$//e<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Directory path
"Set working directory to the current file
"http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * silent! lcd %:p:h

" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omni menu colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hi Pmenu ctermbg=white
"hi PmenuSel ctermbg=yellow ctermfg=black
"hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Multiple windows op
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-q> <C-w>q

" Others
set shell=bash
