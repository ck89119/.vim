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
" enable mouse
set mouse=a
" improve screen refresh for terminal vim
set ttyfast
" set directory color
highlight Directory ctermfg=cyan

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

" python3.7 problem
if has('python3')
  silent! python3 1
endif

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
map <C-J> <C-W>j
" move to the above split
map <C-K> <C-W>k
" move to the left split
map <C-H> <C-W>h
" move to the right split
map <C-L> <C-W>l
" open in new vertical split when find declaration
map <C-W>] :vsp<CR>:exec("tag ".expand("<cword>"))<CR>


" disable F1
noremap <F1> <Esc>

" go to prev tab
" nmap <C-H> gT
" go to next tab
" nmap <C-L> gt
" new tab
" nnoremap <C-T> :tabnew<CR>
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

" json format
nnoremap <leader>j :%!python -m json.tool --no-ensure-ascii<CR>

" shortcut for cnext
" nmap <C-J> :cnext<CR>
" nmap <C-K> :cprevious<CR>

" ctrl-c as <esc>
imap <C-C> <ESC>

" These are to cancel the default behavior of d, D, c, C
" to put the text they delete in the default register.
" Note that this means e.g. "ad won't copy the text into
" register a anymore. You have to explicitly yank it.
" nnoremap d "_d
" vnoremap d "_d
" nnoremap D "_D
" vnoremap D "_D
" nnoremap c "_c
" vnoremap c "_c
" nnoremap C "_C
" vnoremap C "_C
vnoremap p "_dP

"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------
"
" --- EasyMotion
" <Leader>f{char} to move to {char}
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" " Move to line
" map <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

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

" " --- haskell-vim
" " to enable highlighting of forall
" let g:haskell_enable_quantification = 1
" " to enable highlighting of mdo and rec
" let g:haskell_enable_recursivedo = 1
" " to enable highlighting of proc
" let g:haskell_enable_arrowsyntax = 1
" " to enable highlighting of pattern
" let g:haskell_enable_pattern_synonyms = 1
" " to enable highlighting of type roles
" let g:haskell_enable_typeroles = 1
" " to enable highlighting of static
" let g:haskell_enable_static_pointers = 1

" --- YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/private/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
autocmd FileType c map <C-]> :YcmCompleter GoTo<CR>
autocmd FileType cpp map <C-]> :YcmCompleter GoTo<CR>
autocmd FileType python map <C-]> :YcmCompleter GoTo<CR>

" --- nerdtree
map <F6> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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

" " --- vim-go
" au FileType go nmap <leader>r <Plug>(go-run)
" au FileType go nmap <leader>b <Plug>(go-build)
" au FileType go nmap <leader>t <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)
" au FileType go nmap <leader>ds <Plug>(go-def-split)
" au FileType go nmap <leader>dv <Plug>(go-def-vertical)
" au FileType go nmap <leader>dt <Plug>(go-def-tab)
" au FileType go nmap <leader>gd <Plug>(go-doc)
" au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
" au FileType go nmap <leader>gb <Plug>(go-doc-browser)
" au FileType go nmap <leader>s <Plug>(go-implements)
" au FileType go nmap <leader>e <Plug>(go-rename)
" au FileType go nmap <leader>i <Plug>(go-info)

" --- nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

" --- python-mode
let g:pymode_run = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_goto_definition_bind = '<C-]>'
let g:pymode_rope_goto_definition_cmd = 'e'

" --- syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck', 'gobuild']
let g:syntastic_python_checkers = ['flake8']

