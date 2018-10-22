set nocompatible               " be iMproved

" Setting Minimalist Vim Plugin Manager 
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Original repos on github
Plug 'junegunn/vim-plug'
Plug 'othree/html5.vim'
Plug 'othree/html5-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/jspc.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'othree/vim-autocomplpop'
"Plug 'ajh17/VimCompletesMe'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'digitaltoad/vim-jade'
Plug 'mhinz/vim-signify'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'ronakg/quickr-preview.vim'

" Vim 7.2+
Plug 'nathanaelkane/vim-indent-guides'

" Colorscheme
Plug 'nanotech/jellybeans.vim'

" On https://github.com/vim-scripts/
Plug 'vim-scripts/L9'
Plug 'vim-scripts/jsbeautify'

call plug#end()

" Initialize for common setup
syntax on
filetype plugin on
set hidden

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
set completeopt=menu,preview
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

"vim-autocomplpop
let g:acp_behaviorPhpOmniLength=1
let g:acp_behaviorSnipmateLength = 1

"imap <S-Tab> <Plug>snipMateNextOrTrigger

"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_match_window = 'min:4,max:28'
let g:ctrlp_regexp = 0
let g:ctrlp_clear_cache_on_exit = 0
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
map <F4> <C-P><C-\>w
nnoremap <F5> :CtrlPMRU<CR>
nnoremap <F8> :CtrlPBookmarkDir<CR>
nnoremap <leader>d :CtrlPBookmarkDirAdd %:p:h<CR>
" http://vim.wikia.com/wiki/Find_in_files_within_Vim
map <F9> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>
map <F10> :execute " grep -srnw % -e " . expand("<cword>") . " " <bar> cwindow<CR>

" Airline
set laststatus=2
let g:airline_detect_paste=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#tabline#enabled = 0
set showtabline=0
let g:airline_powerline_fonts=0
let g:airline_theme='jellybeans'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_exclude_preview = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1

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
"autocmd BufEnter * silent! lcd %:p:h
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

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

" tacahiroy/ctrlp-funky
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_funky_multi_buffers = 1

" Others
set shell=bash
autocmd Filetype gitcommit setlocal spell textwidth=72
nnoremap <Leader>b :ls<CR>:b<Space>
nmap <leader>n :cn<CR>
nmap <leader>p :cp<CR>
let g:netrw_banner = 0
