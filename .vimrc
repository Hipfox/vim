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
if v:version > 709
  Plug 'othree/csscomplete.vim'
endif
Plug 'hail2u/vim-css3-syntax'
Plug 'shawncplus/phpcomplete.vim'
Plug 'othree/vim-autocomplpop'
"Plug 'ajh17/VimCompletesMe'
Plug 'MarcWeber/vim-addon-mw-utils'
if v:version < 800
  Plug 'tomtom/tlib_vim', { 'tag': '1.22' }
else
  Plug 'tomtom/tlib_vim'
endif
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-conflicted'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'vim-syntastic/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'digitaltoad/vim-jade'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/vim-easy-align'

Plug 'machakann/vim-highlightedyank'

if v:version < 800
  if !exists('##TextYankPost')
		map y <Plug>(highlightedyank)
	endif
endif

" Vim 7.2+
if v:version >= 702
  Plug 'nathanaelkane/vim-indent-guides'
endif

" Colorscheme
"Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/seoul256.vim'

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
"colorscheme jellybeans
let g:seoul256_background = 233
colorscheme seoul256

let mapleader = ','
let g:mapleader = ","

set ttyfast
set backspace=indent,eol,start
set incsearch
set hlsearch
set ignorecase
set smartcase
set ruler
set lazyredraw
set cursorline
set redrawtime=10000

set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set splitbelow
set splitright

set fileencodings=utf-8,big5,default
set encoding=utf8
set fileformat=unix
set ambiwidth=double

set pastetoggle=<F2>
set noerrorbells
set novisualbell
set wildmenu
set wildmode=list:longest,full
set completeopt=longest,menuone
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
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

  augroup EditVim
    autocmd!
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    " fugitive
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd Filetype gitcommit setlocal spell textwidth=72
    " If you prefer the Omni-Completion tip window to close when a selection is
    " made, these lines close it on movement in insert mode or when leaving
    " insert mode
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
  augroup END

  augroup VimCSS3Syntax
    autocmd!
    autocmd FileType css setlocal iskeyword+=-
  augroup END
endif

"vim-autocomplpop
let g:acp_behaviorPhpOmniLength=1
let g:acp_behaviorSnipmateLength = 1

" http://vim.wikia.com/wiki/Find_in_files_within_Vim
map <F3> :execute " Rg " . expand("<cword>")<CR>
map <F9> :execute " grep -srnw --binary-files=without-match --exclude-dir=tmp --exclude-dir=files --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>
map <F10> :execute " grep -srnw % -e " . expand("<cword>") . " " <bar> cwindow<CR>
map <F11> :execute " grep -sRnw --binary-files=without-match --exclude-dir=tmp --exclude-dir=files --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>

" gitgutter
nnoremap <F12> :GitGutterToggle<CR>
nmap <Leader>k <Plug>(GitGutterPrevHunk)
nmap <Leader>j <Plug>(GitGutterNextHunk)
let g:gitgutter_enabled = 0
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" lightline
set laststatus=2
set showtabline=0
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

let g:syntastic_php_checkers=['php']
let g:syntastic_php_phpcs_args=' --standard=Drupal --extensions=php,module,inc,install,test,profile,theme'
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
nnoremap <leader>g :cd $PWD<CR>:pwd<CR>

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

" Sneak config
let g:sneak#label = 1

" Resize split windows
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize +20"<CR>
nnoremap <silent> <Leader>< :exe "vertical resize -20"<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Others
set shell=bash
"nnoremap <Leader>b :ls<CR>:b<Space>
nmap <leader>n :cn<CR>
nmap <leader>p :cp<CR>
let g:netrw_banner = 0
"Hitting F5 will clean out all that trailing whitespace or tabs.
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" Fzf, Ripgrep
"let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.6  }  }
let g:fzf_layout = { 'down': '60%'  }
let g:fzf_preview_window = []
nnoremap <leader>fl :Lines
nnoremap <leader>fb :BLines
nnoremap <leader>fz :Files<CR>
nnoremap <leader>fg :GFiles
nnoremap <leader>f? :GFiles?
nnoremap <leader>fr :Rg
nnoremap <leader>fc :Commits
nnoremap <leader>fh :History<CR>
nnoremap <leader>b  :Buffers<CR>

command! -bang -nargs=* Rg call fzf#vim#grep("rg --follow --column --line-number --no-heading --color=always --smart-case -g '!log' -g '!files' -g '!*.sql' -- ".shellescape(<q-args>), 1, {}, <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = "rg --follow --column --line-number --no-heading --color=always --smart-case -g '!log' -g '!files' -- %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
