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
"Plugin 'othree/eregex.vim'
Plugin 'othree/vim-autocomplpop'
Plugin 'jimyhuang/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'
Plugin 'digitaltoad/vim-jade'
Plugin 'mhinz/vim-signify'
Plugin 'majutsushi/tagbar'
"Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'easymotion/vim-easymotion'
Bundle 'inside/vim-grep-operator'

" Vim 7.2+
Plugin 'nathanaelkane/vim-indent-guides'

" Colorscheme
"Plugin 'chriskempson/base16-vim'
Plugin 'nanotech/jellybeans.vim'
"Plugin 'junegunn/seoul256.vim'

" On https://github.com/vim-scripts/
Plugin 'L9'
Plugin 'jsbeautify'

call vundle#end()

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall!
endif

" Initialize for common setup
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
set lazyredraw
set cursorline

set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

set fileencodings=utf-8,big5,default
set encoding=utf8
set fileformat=unix
set ambiwidth=double

set pastetoggle=<F2>
set noerrorbells
set novisualbell
set wildmenu
set wildmode=longest,list,full
set keywordprg=":help"
set ttimeout
set ttimeoutlen=50
" save local marks a-z for up to 100 files ('100), save global marks A-Z upon exit (f1)
set viminfo='100,f1

" Syntax highlighting borrow from http://drupal.org/node/29325
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

" Tab key
nnoremap <C-t> :tabnew<CR>
nnoremap <leader>[ :tabprevious<CR>
nnoremap <leader>] :tabnext<CR>
nnoremap <leader>t :tabnext<CR>
nnoremap <leader><tab> :tabnext<CR>

" Omnifunc
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving insert mode
"inoremap <leader><tab> <C-x><C-o>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_match_window = 'min:4,max:28'
let g:ctrlp_regexp = 0
" ctrlp - replace underscore match with directory separator(CRM specific)
let g:ctrlp_abbrev = {
 \ 'gmode': 'i',
 \ 'abbrevs': [
 \  {
 \    'pattern': '_',
 \    'expanded': '/',
 \    'mode': 'prz',
 \  }
 \ ]
\ }
nnoremap <F3> :CtrlPBuffer<CR>
nnoremap <F4> :CtrlP<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Airline
set laststatus=2
let g:airline_detect_paste=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=0
let g:airline_theme='jellybeans'
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

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
" Directory path
" Set working directory to the current file
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * silent! lcd %:p:h
nnoremap <leader>cd :lcd %:p:h<CR>

" quick grep
let g:grep_operator_set_search_register = 1
set grepprg=git\ grep\ -n\ $*
nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
nmap <C-e> <Leader>giw
vmap <C-v> <Leader>g
nmap <leader>n :cn<CR>
nmap <leader>p :cp<CR>

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
nnoremap <leader>c <C-w>c
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-q> <C-w>q

" EasyMotion config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Resize split windows
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize +20"<CR>
nnoremap <silent> <Leader>< :exe "vertical resize -20"<CR>

" fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

" Others
set shell=bash
autocmd Filetype gitcommit setlocal spell textwidth=72
