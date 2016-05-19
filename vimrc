" ck89119's vimrc inspired by vgod <https://github.com/vgod/vimrc>
" Cao (ck89119) Kai <ck89119@gmail.com>

" For pathogen.vim: auto load all plugins in .vim/bundle
let g:pathogen_disabled = []
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"---------------------------------------------------------------------------
" GENERAL SETTINGS
"---------------------------------------------------------------------------

" not compatible with the old-fashion vi mode
set nocompatible
" allow backspacing over everything in insert mode
set bs=2
" keep 50 lines of command line history
set history=50
" show the cursor position all the time
set ruler
" auto read when file is changed from outside
set autoread
" show line number
set number
" yank to the system register (*) by default
set clipboard=unnamed
" Cursor shows matching ) and }
set showmatch
" Show current mode
set showmode
" start wild expansion in the command line using <TAB>
set wildchar=<TAB>
" wild char completion menu
set wildmenu
" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc
" auto indentation
set autoindent
" copy the previous indentation on autoindenting
set copyindent
" incremental search
set incsearch
" no *~ backup files
set nobackup
" ignore case when searching
set ignorecase
" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smartcase
" insert tabs on the start of a line according to context
set smarttab
" search highlighting
set hlsearch
" highlight current line
"set cursorline
"highlight CursorLine guibg=#003853 ctermbg=24  gui=none cterm=none
" 256 color mode
set t_Co=256
" relative number
set relativenumber
" enable mouse
set mouse=a
" improve screen refresh for terminal vim
set ttyfast

" code folding
set foldmethod=indent
set nofoldenable

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" syntax highlight
syntax on
" Enable filetype detection
filetype on
" Enable filetype-specific indenting
filetype indent on
" Enable filetype-specific plugins
filetype plugin on

" TAB setting{
  " replace <TAB> with spaces
  set expandtab
  set shiftwidth=4
  set tabstop=4
  set softtabstop=4
  " do not replace <TAB> with spaces in Makefile
  au FileType Makefile set noexpandtab
  " <TAB> width will be 2 spaces when editing cpp file
  au FileType cpp set shiftwidth=2 tabstop=2 softtabstop=2
"}

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction
"}

" GUI color and font settings
if has("gui_running")
  if has("unix")
    let s:uname = system("uname")
      if s:uname == "Darwin\n"
        " Do Mac stuff here
        set guifont=Monaco\ for\ powerline:h12
      endif
  endif
  set background=dark
  colors solarized
endif

" Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin1
set ffs=unix,dos,mac

"---------------------------------------------------------------------------
" USEFUL SHORTCUTS
"---------------------------------------------------------------------------

" set leader to ,
let mapleader=" "
let g:mapleader=" "

" move to the below split
map <leader>wj <C-W>j
" move to the above split
map <leader>wk <C-W>k
" move to the left split
nmap <leader>wh <C-W>h
" move to the right split
nmap <leader>wl <C-W>l

" disable F1
noremap <F1> <Esc>

" go to prev tab
nmap <C-H> gT
" go to next tab
nmap <C-L> gt
" new tab
nmap <C-T> :tabnew<CR>
" close tab
" nmap <C-W> :tabclose<CR>

" turn off search highlighting
nmap <leader>/ :nohl<CR>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" change working directory to that of the current file
nnoremap <leader>. :lcd %:p:h<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" delete spaces at the end of lines
nnoremap <leader>s :%s/\s\+$//<CR>

" search and highlight current word
nmap <leader>h :/<C-R>=expand("<cword>")<CR><CR>

" shortcut for cnext
nmap <C-J> :cnext<CR>
nmap <C-K> :cprevious<CR>

"---------------------------------------------------------------------------
" PROGRAMMING SHORTCUTS
"---------------------------------------------------------------------------

" --- cscope
" set cscopequickfix=s-,c-,d-,i-,t-,e-
" nmap <F8> :!cscope -Rbq <CR>
if has("cscope")
  if has("unix")
    set csprg=/usr/bin/cscope
    let s:uname = system("uname")
      if s:uname == "Darwin\n"
        " Do Mac stuff here
        set csprg=/usr/local/bin/cscope
      endif
  endif
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  " else add database pointed to by environment
  " elseif $CSCOPE_DB != ""
      "cs add $CSCOPE_DB
  endif
  set csverb
endif

nmap fc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap fd :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap fe :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap fg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap fi :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap fs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap ft :cs find t <C-R>=expand("<cword>")<CR><CR>

" --- one-key compile and run
nmap <leader>r :call CompileAndRun()<CR>
func! CompileAndRun()
exec "w"
if &filetype=="cpp"
  exec "!
  \ clear;
  \ g++ -std=c++11 % -o %<;
  \ ./%<;
  \ rm %<;"
elseif &filetype=="c"
  exec "!
  \ clear;
  \ gcc % -o %<;
  \ ./%<;
  \ rm %<;"
elseif &filetype=="sh"
  exec "!
  \ clear;
  \ bash %;"
elseif &filetype=="python"
  exec "!
  \ clear;
  \ python %;"
elseif &filetype=="scheme"
  exec "!
  \ clear;
  \ scheme < %;"
endif
endfunc

" --- one-key compile and debug
nmap <leader>d :call CompileAndDebug()<CR>
func! CompileAndDebug()
exec "w"
exec "!
\ clear;
\ g++ -std=c++11 -g % -o %<;
\ lldb %<;
\ rm %<;
\ rm -rf %<.dSYM;"
endfunc

"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------

" --- EasyMotion
" let g:EasyMotion_leader_key = '<Leader>m' " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

" --- TagBar
" toggle TagBar with F8
nnoremap <silent> <F8> :TagbarToggle<CR>
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

" --- vim-airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0


" --- haskell-vim
" to enable highlighting of forall
let g:haskell_enable_quantification = 1
" to enable highlighting of mdo and rec
let g:haskell_enable_recursivedo = 1
" to enable highlighting of proc
let g:haskell_enable_arrowsyntax = 1
" to enable highlighting of pattern
let g:haskell_enable_pattern_synonyms = 1
" to enable highlighting of type roles
let g:haskell_enable_typeroles = 1
" to enable highlighting of static
let g:haskell_enable_static_pointers = 1

" --- YouCompleteMe
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '~/.vim/private/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_highlighting = 0

" --- nerdtree
map <F6> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeWinSize=30
set guioptions-=T
set guioptions-=L
let NERDTreeIgnore = ['\.pyc$', '\.o$']

" --- ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<F9>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "private"]

" -- vim-go
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>ds <Plug>(go-def-split)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)
au FileType go nmap <leader>dt <Plug>(go-def-tab)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>i <Plug>(go-info)
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" -- nerdcommenter
let NERDSpaceDelims=1

" -- python-mode
let g:pymode_run = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_goto_definition_bind = '<C-]>'
let g:pymode_rope_goto_definition_cmd = 'vnew'
