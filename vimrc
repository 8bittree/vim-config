" vim: fdm=marker
""""" Using VIM, not vi, this must be first
set nocompatible

" Detect OS {{{
"let os = substitute(system('uname'), '\n', '', '')
" New detection scheme from github.com/bling/dotvim/master/vimrc
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')
"}}}

" Set up neobundle {{{
if has('vim_starting')
	" Include neobundle in the rtp
	if s:is_windows
		let s:bundle_dir="$HOME/vimfiles/bundle"
	else
		let s:bundle_dir="$HOME/.vim/bundle"
	endif
	let &runtimepath=&runtimepath.','.s:bundle_dir.'/neobundle.vim'
endif
call neobundle#begin(s:bundle_dir)
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

call neobundle#end()
" Generate helptags
NeoBundleDocs
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove all autocommands to avoid loading them twice
autocmd!

" Auto reload .vimrc file when saving it
if has('autocmd')
	autocmd BufWritePost .vimrc source $MYVIMRC
endif

set history=512 " How many lines of history to remember

" Don't make a backup file
set nobackup
" Do make a swap file
set swapfile

if has('undofile')
	" Make an undo file for persistent undo tree
	set undofile
	" Keep working directories clean by putting and undo files in dedicated
	" directories
	set undodir=~/.vim/vimundo
	if has('autocmd')
		autocmd BufNew COMMIT_MSG setlocal noundofile
	endif
endif

" Enable switching away from buffers without saving
set hidden

set autoread " Update buffer when a file is changed from the outside

" Tabs (put here instead of Editing for filetype settings overwriting)
" Use :retab! to make an existing file obey these settings
set tabstop=4 " Number of columns a tab is represented by
set shiftwidth=4 " Number of columns to move text when using < and >
set softtabstop=4 " see :help softtabstop
set noexpandtab " Don't expand tabs into spaces

" Autoindentation (here for the same reason as tabs)
set autoindent " keep the previous line's indentation
set smartindent " keeps previous line's indent, indent line after {, puts a } on a new line at same level as matching {

" Enable filetype detection, filetype specific plugins, and filetype specific
" indentation
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins used
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion: https://github.com/Lokaltog/vim-easymotion
"	Easily move around the window

" Fugitive: https://github.com/tpope/vim-fugitive
"	A Git wrapper so awesome, it should be illegal

" Gundo: http://sjl.bitbucket.org/gundo.vim/
"	Easily browse the undo tree

" Keepcase: http://www.vim.org/scripts/script.php?script_id=6
"	Case hyper-sensitive substitution

" Repeat: https://github.com/tpope/vim-repeat
"	enable repeating supported plugin maps with "."

" Slimv:
"

" Solarized: http://ethanschoonover.com/solarized
"	Colorscheme that works well in light and dark

" Surround: https://github.com/tpope/vim-surround
"	quoting/parenthesizing made simple

" Ultisnips: http://www.vim.org/scripts/script.php?script_id=2715
"	Textmate-like snippets

" Unite: https://github.com/Shougo/unite.vim
"	Unite and create user interfaces
"	This one does a lot of stuff. One of those things is file system
"	searching

" Vimproc: https://github.com/Shougo/vimproc.vim
"	Interactive command execution in Vim. Makes Unite be less slow.
"	Requires native compilation.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=3	" Keeps at least 3 visible lines around the cursor at all times

if exists('+relativenumber')
	set relativenumber " Displays the line number relative to the cursor
endif

" Configure status line
" modified, file, file type, read only, column, virtual column, line number, lines
set statusline=%m\ %t\ %y\ %r%=Buf:%n\ Char:%b\ Col:%c%V\ Line:%l/%L
set laststatus=2 " Turn on the statusline

set cursorline " Highlight the line the cursor is on
set cursorcolumn " Highlight the column the cursor is on

" Theme, uses solarized
syntax on
set background=dark
if has('gui_running')
	set t_Co=256
	colorscheme solarized
	set gfn=Consolas:h9,Source_Code_Pro:h9,Menlo:h10,Dejavu_Sans_Mono:h9,*
	"if os == "Linux"
	"	set gfn=Dejavu\ Sans\ Mono\ 9
	"endif
	set guioptions-=T " Don't display the toolbar
	set guioptions-=e " use ASCII tabs, not GUI tabs (e)
endif
if $TERM == 'xterm-256color'
	colorscheme solarized
endif

set incsearch " Incremental search (search as you type)
set ignorecase " Ignore case when searching
set smartcase " Don't ignore case when typing capitals in the search term
set hlsearch " Highlight search matches

set wildmenu " Show matches for command completion in status bar
set wildmode=longest:full " Command completion, add longest match first then sequentially match complete options

set mouse=a " Enable mouse usage
set mousehide " Hide mouse while typing

" Configure whitespace characters
try
	" EOL:u21a9,tab:u25b8 space,trail:u2423
	set listchars=eol:↩,tab:▸\ ,trail:␣
catch
	set listchars=eol:$,tab:>\ ,trail:^
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start " allow backspacing over everything

" Disable automatic hard text wrapping
set textwidth=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key (Re)maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ','

" Easily clear search to remove highlights
nmap <silent> <leader>/ :nohlsearch<CR>

" Toggle the display of whitespace characters
nmap <leader>l :set list!<cr>

" Easily toggle Gundo window
nmap <leader>u :GundoToggle<CR>

" Just type ; instead of : to enter a command
" nnoremap makes sure that ; does what : originally did, regardless of any remmapping of :
nnoremap ; :

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Save with Ctrl-s
nmap <C-s> :up<CR>
imap <C-s> <ESC>:up<CR>a
cmap <C-s> <ESC>:up<CR>

" Quickly edit files in the same directory as the current file
cnoremap %% <C-R>=expand("%:p:h")."/"<CR>

" Make Ultisnips friendly with YouCompleteMe
let g:UltiSnipsExpandTrigger='<C-j>'

" Disable default EasyMotion mappings
let g:EasyMotion_do_mapping=0
" Activate EasyMotion with space
nmap <Space> <Plug>(easymotion-s)
omap <Space> <Plug>(easymotion-s)
" Enable EasyMotion lazy shift key usage for letters, numbers, and symbols
let g:EasyMotion_smartcase=1
let g:EasyMotion_use_smartsign_us=1

" Unite mappings
nnoremap <leader>ew :Unite -no-split -start-insert -buffer-name=files file_rec/async<CR>
" TODO: this one needs improvement, but the -horizontal option seems to be broken
nnoremap <leader>es :split<CR>:Unite -no-split -start-insert -buffer-name=files file_rec/async<CR>
nnoremap <leader>ev :Unite -vertical -start-insert -buffer-name=files file_rec/async<CR>
nnoremap <leader>et :Unite -tab -start-insert -buffer-name=files file_rec/async<CR>
" Ignore VCS directories when searching for a file with Unite
call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '\(\.git\|\.svn\|pyc$\|\.swp\)')
" User fuzzy matching in Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Better Unite sorting
call unite#filters#sorter_default#use(['sorter_rank'])

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable directory specific .vimrc w/o allowing arbitrary code execution
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set secure
