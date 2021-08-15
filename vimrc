""""" Using VIM, not vi, this must be first
set nocompatible

" Detect OS {{{
"let os = substitute(system('uname'), '\n', '', '')
" New detection scheme from github.com/bling/dotvim/master/vimrc
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')
"}}}

let mapleader = ','

if has('vim_starting')
	if s:is_windows
		let s:dotvim_dir=$HOME.'/vimfiles'
	else
		let s:dotvim_dir=$HOME.'/.vim'
	endif
endif

" Remove all autocommands to avoid loading them twice
autocmd!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional files to source
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand('~/.vimrc_local'))
	source ~/.vimrc_local
endif

" Set up Vim-Plug
call plug#begin()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins used {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abolish: http://github.com/tpope/vim-abolish {{{
" Changing multiple variants of a word
Plug 'tpope/vim-abolish'
"}}}

" Dracula: https://github.com/dracula/vim
"	A dark theme for Vim
Plug 'dracula/vim', {'as': 'dracula'}

" EasyMotion: https://github.com/Lokaltog/vim-easymotion {{{
"	Easily move around the window
if version >= 703
	Plug 'Lokaltog/vim-easymotion'
	" Disable default EasyMotion mappings
	let g:EasyMotion_do_mapping=0
	" Activate EasyMotion with space
	nmap <Space> <Plug>(easymotion-s)
	omap <Space> <Plug>(easymotion-s)
	" Enable EasyMotion lazy shift key usage for letters, numbers, and symbols
	let g:EasyMotion_smartcase=1
	let g:EasyMotion_use_smartsign_us=1
endif
"}}}

" Elm-vim: https://github.com/ElmCast/elm-vim {{{
"	Elm language support
Plug 'elmcast/elm-vim'
"}}}

" Fugitive: https://github.com/tpope/vim-fugitive "{{{
"	A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>
"}}}

" Gitgutter: https://github.com/airblade/vim-gitgutter {{{
"	Show a git diff in the sign column, stage/revert hunks
Plug 'airblade/vim-gitgutter'
"}}}

" GLSL: https://github.com/tikhomirov/vim-glsl
"	OpenGL Shading language support
Plug 'tikhomirov/vim-glsl'

" Gruvbox: https://github.com/morhetz/gruvbox
"	Colorscheme with light mode and dark mode
Plug 'morhetz/gruvbox'

" Iceberg: https://github.com/cocopon/iceberg.vim
"	A dark blue colorscheme
Plug 'cocopon/iceberg.vim'

" Nord Vim: https://github.com/arcticicestudio/nord-vim
"	An arctic, north-bluish clean and elegant Vim color theme
Plug 'arcticicestudio/nord-vim'

" Obsession: https://github.com/tpope/vim-obsession {{{
"	Automatic session management
Plug 'tpope/vim-obsession'
"}}}

" Racer: https://github.com/racer-rust/vim-racer {{{
"	Use Racer for Rust code completion and navigation
if executable("racer")
	let g:racer_cmd=$HOME . "/.cargo/bin/racer"
	Plug 'racer-rust/vim-racer'
	au FileType rust nmap gd <Plug>(rust-def)
	au FileType rust nmap gs <Plug>(rust-def-split)
	au FileType rust nmap gx <Plug>(rust-def-vertical)
	au FileType rust nmap <leader>gd <Plug>(rust-doc)
endif
"}}}

" Rainbow: https://github.com/luochen1990/rainbow
"	Rainbowifies parenthesis, brackets, tags, etc.
let g:rainbow_active=1
Plug 'luochen1990/rainbow'

" Repeat: https://github.com/tpope/vim-repeat {{{
"	enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'
"}}}

" Ron.vim: https://github.com/ron-rs/ron.vim {{{
"	Syntax support for RON
Plug 'ron-rs/ron.vim'
"}}}

" Rust: https://github.com/rust-lang/rust.vim {{{
"	Rust language support
Plug 'rust-lang/rust.vim'
"}}}

" Slimv: https://github.com/kovisoft/slimv {{{
"	Superior Lisp Interaction Mode for Vim
"if has('python')
"	if executable('ccl64') && s:is_macvim
"		let g:slimv_swank_cmd='!osascript -e "tell application \"Terminal\" to do script \"ccl64 -l ~/.vim/bundle/slimv_3c52652519/slime/start-swank.lisp\""'
"	endif
"	Plug 'kovisoft/slimv'
"endif
"}}}

" Solarized: http://ethanschoonover.com/solarized {{{
"	Colorscheme that works well in light and dark
Plug 'altercation/vim-colors-solarized'
"}}}

" Surround: https://github.com/tpope/vim-surround {{{
"	quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
"}}}

" Syntastic: https://github.com/vim-syntastic/syntastic {{{
"	Syntax and style checking
Plug 'vim-syntastic/syntastic'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_mode_map = {
	\ "mode": "passive",
	\ "active_filetypes": [],
	\ "passive_filetypes": [] }
" }}}

" Ultisnips: http://www.vim.org/scripts/script.php?script_id=2715 {{{
"	Textmate-like snippets
if has('python3')
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	if !executable('cmake') && !has('lua')
		Plug 'JazzCore/neocomplcache-ultisnips'
	endif
endif
"}}}

" Undotree: http://github.com/mbbill/undotree {{{
"	Easily browse the undo tree
Plug 'mbbill/undotree'
" Easily toggle the undotree window
nmap <leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1
"}}}

" Vim-Airline: https://github.com/vim-airline/vim-airline.git {{{
"   Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
set noshowmode " airline handles showing the mode, no need for the native method
set encoding=utf-8
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%{airline#util#wrap(airline#extensions#obsession#get_status(),0)}C:%B %#__accent_bold#%{g:airline_symbols.linenr} %l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#:%c%V'
"}}}

" Vim-Airline-Themes: https://github.com/vim-airline/vim-airline-themes.git {{{
"   Themes for vim-airline
Plug 'vim-airline/vim-airline-themes'
"}}}

" Vim-Toml: https://github.com/cespare/vim-toml {{{
" Syntax support for TOML
Plug 'cespare/vim-toml'
" }}}

" Autocompletion
if executable("node")
	" CoC https://github.com/neoclide/coc.nvim {{{
	"	Vim ensmartening (inc. code completion)
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	"}}}
elseif has("python3") && executable("cmake")
	" YouCompleteMe: https://github.com/ycm-core/YouCompleteMe {{{
	"	a code-completion engine
	let g:ycm_key_list_select_completion=[]
	let g:ycm_key_list_previous_completion=[]
	Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
	"}}}
elseif has("lua")
	" Neocomplete: https://github.com/Shougo/neocomplete.vim {{{
	"	Quick Lua-based autocompletion
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#enable_smart_case = 1
	if !exists('g:neocomplete#sources')
		let g:neocomplete#sources = {}
	endif
	let g:neocomplete#sources._ = ['buffer', 'member', 'syntax']
	if has("python3")
		let g:neocomplete#sources._ += ['ultisnips']
	endif
	let g:neocomplete#sources.vim = ['vim']
	Plug 'Shougo/neocomplete.vim'
	"}}}
else
	" Neocomplcache: https://github.com/Shougo/neocomplcache.vim {{{
	"	Slow VimScript-based autocompletion
	Plug 'Shougo/neocomplcache.vim'
	let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_enable_smart_case = 1
	"}}}
endif
"}}}

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto reload .vimrc file when saving it
if has('autocmd')
	autocmd BufWritePost .vimrc source $MYVIMRC
endif

set history=512 " How many lines of history to remember

" Don't make a backup file
set nobackup
" Do make a swap file
set swapfile
let &directory=s:dotvim_dir.'/vimswp//'

" Undo persistence {{{
if has('persistent_undo')
	" Make an undo file for persistent undo tree
	set undofile
	" Keep working directories clean by putting and undo files in dedicated
	" directories
	let &undodir=s:dotvim_dir.'/vimundo'
	if has('autocmd')
		autocmd BufNew COMMIT_MSG setlocal noundofile
	endif
endif
"}}}

" Enable switching away from buffers without saving
set hidden

set autoread " Update buffer when a file is changed from the outside

" Tabs (put here instead of Editing for filetype settings overwriting) {{{
" Use :retab! to make an existing file obey these settings
set tabstop=4 " Number of columns a tab is represented by
set shiftwidth=4 " Number of columns to move text when using < and >
set softtabstop=4 " see :help softtabstop
"}}}

" Autoindentation (here for the same reason as tabs)
set autoindent " keep the previous line's indentation
set smartindent " keeps previous line's indent, indent line after {, puts a } on a new line at same level as matching {

" Enable filetype detection, filetype specific plugins, and filetype specific
" indentation
filetype plugin indent on
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=3	" Keeps at least 3 visible lines around the cursor at all times

if exists('+relativenumber')
	set relativenumber " Displays the line number relative to the cursor
endif

" Configure status line
" modified, file, file type, read only, column, virtual column, line number, lines
" Left defined in case airline gets toggled off for whatever reason
set statusline=%m\ %t\ %y\ %r%=Buf:%n\ Char:%B\ Col:%c%V\ Line:%l/%L

if has('autocmd')
	autocmd WinLeave * setlocal nocursorline
	autocmd WinLeave * setlocal nocursorcolumn
	autocmd WinEnter * setlocal cursorline
	autocmd WinEnter * setlocal cursorcolumn
else
	set cursorline " Highlight the line the cursor is on
	set cursorcolumn " Highlight the column the cursor is on
endif

" Theme, uses solarized {{{
syntax on
set background=dark
if has('gui_running')
	set t_Co=256
	try
		colorscheme dracula
	catch
		try
			colorscheme molokai_mod
		catch
			colorscheme herald
		endtry
	endtry
	set guifont=Inconsolata-g_for_Powerline:h8:cANSI:qDRAFT,monofur\ for\ Powerline:h12,InputMonoNarrow\ Light:h10,Ubuntu\ Mono\ 9,Consolas:h9,Source_Code_Pro:h9,Menlo:h10,Dejavu\ Sans\ Mono\ 8,Dejavu_Sans_Mono:h9,Bitstream\ Vera\ Sans\ Mono\ 9,*
	"if os == "Linux"
	"	set gfn=Dejavu\ Sans\ Mono\ 9
	"endif
	set guioptions-=T " Don't display the toolbar
	set guioptions-=e " use ASCII tabs, not GUI tabs (e)
	" Don't use vertical scrollbars
	set guioptions-=r
	set guioptions-=R
	set guioptions-=l
	set guioptions-=L
endif
if $TERM == 'xterm-256color' || $TERM =~ 'screen.*'
	set t_Co=256
	colorscheme molokai_mod " Seems to work better in a terminal than Solarized
endif
"}}}

" Search {{{
set incsearch " Incremental search (search as you type)
set ignorecase " Ignore case when searching
set smartcase " Don't ignore case when typing capitals in the search term
set hlsearch " Highlight search matches
"}}}

set wildmenu " Show matches for command completion in status bar
set wildmode=longest:full " Command completion, add longest match first then sequentially match complete options

set mouse=a " Enable mouse usage
set mousehide " Hide mouse while typing

" Configure whitespace characters {{{
try
	" EOL:u21a9,tab:u25b8 space,trail:u2423
	set listchars=eol:↩,tab:▸\ ,trail:␣
catch
	set listchars=eol:$,tab:>\ ,trail:^
endtry
"}}}
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start " allow backspacing over everything

" Disable automatic hard text wrapping
set textwidth=0
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key (Re)maps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Easily clear search to remove highlights
nmap <silent> <leader>/ :nohlsearch<CR>

" Toggle the display of whitespace characters
nmap <leader>l :set list!<cr>

" Just type ; instead of : to enter a command
" Opens the command window instead of command line, thus enabling full vim
" editing capabilities. Also jumps straight to insert mode for convenience.
" TODO: set up smart auto-complete for stuff like :help in the command window.
" For now, using : to access the command line still has auto-complete
" nnoremap makes sure that ; does what : originally did, regardless of any remmapping of :
nnoremap ; q:i

" Better window navigation {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"}}}

" Save with Ctrl-s
nmap <C-s> :up<CR>
imap <C-s> <ESC>:up<CR>a
cmap <C-s> <ESC>:up<CR>

" Quickly edit files in the same directory as the current file
cnoremap %% <C-R>=fnameescape(expand("%:p:h")."/")<CR>

" New lines start a new undo step
inoremap <CR> <C-G>u<CR>

let g:EclimCompletionMethod = 'omnifunc'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable directory specific .vimrc w/o allowing arbitrary code execution
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set secure
