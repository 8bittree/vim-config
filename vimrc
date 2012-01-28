""""" Using VIM, not vi, this must be first
set nocompatible

" Set up the os variable for later use
let os = substitute(system('uname'), "\n", "", "")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto reload .vimrc file when saving it
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

set history=512 " How many lines of history to remember

" Don't make a backup file
set nobackup
" Do make a swap file
set swapfile

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

filetype plugin indent on " Enable filetype detection, filetype specific plugins, and filetype specific indentation

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins used
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen: http://www.vim.org/scripts/script.php?script_id=2332
"	puts each plugin into its own directory for easier management
call pathogen#infect()

" Ultisnips: http://www.vim.org/scripts/script.php?script_id=2715
"	Textmate-like snippets

" Gundo: http://sjl.bitbucket.org/gundo.vim/
"	Easily browse the undo tree

call pathogen#helptags() " generate helptags for installed plugins

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=3	" Keeps at least 3 visible lines around the cursor at all times

set number " Display line numbers
" set relativenumber " Displays the line number relative to the cursor

" Configure status line
" modified, file, file type, read only, column, virtual column, line number, lines
set statusline=%m\ %t\ %y\ %r%=Buf:%n\ Char:%b\ Col:%c%V\ Line:%l/%L
set laststatus=2 " Turn on the statusline

set cursorline " Highlight the line the cursor is on
set cursorcolumn " Highlight the column the cursor is on

" Theme, uses modified version of molokai
syntax on
if has("gui_running")
	set t_Co=256
	colorscheme molokai_mod
	if os == "Linux"
		set gfn=Dejavu\ Sans\ Mono\ 9
	elseif os == "Darwin"
		set gfn=Menlo:h10
	else
		set gfn=*
	endif
	set guioptions-=T " Don't display the toolbar
endif
if $TERM == 'xterm-256color'
	colorscheme molokai_mod
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
" EOL:u21a9,tab:u25b8 space,trail:u2423
set listchars=eol:↩,tab:▸\ ,trail:␣

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start " allow backspacing over everything

" Disable automatic hard text wrapping
set textwidth=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key (Re)maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" Easily clear search to remove highlights
nmap <silent> <leader>/ :nohlsearch<CR>

" Toggle the display of whitespace characters
nmap <leader>l :set list!<cr>

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
map <leader>ew :edit %%
map <leader>es :split %%
map <leader>ev :vsplit %%
map <leader>et :tabedit %%

" Make Ultisnips completion keys consistent
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable directory specific .vimrc w/o allowing arbitrary code execution
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set secure
