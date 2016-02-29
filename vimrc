" ----------------------------------------------------------------------------
"   .vimrc                                                                {{{
" ----------------------------------------------------------------------------

" Allow vim to break compatibility with vi
set nocompatible " This must be first, because it changes other options

" }}}-------------------------------------------------------------------------
"   Plugin                                                                {{{
" ----------------------------------------------------------------------------

" Installing the Plug plugin manager, and all the plugins are included in this
" other file.
source $HOME/.vim/plug.vim


" }}}-------------------------------------------------------------------------
"   Base Options                                                          {{{
" ----------------------------------------------------------------------------
" Set the leader key to <space> instead of \ because it's easier to reach
let mapleader = "\<Space>"
scriptencoding utf-8            " utf-8 all the way
set encoding=utf-8
set ffs=unix,mac,dos
set spell
set spelllang=en_us
                                " Set my personal spelling file
set spellfile=$HOME/.vim/spell/en.utf-8.add
set ttyfast                     " Indicates a fast terminal connection
set backspace=indent,eol,start  " Allow backspaceing over autoindent, line breaks, starts of insert
set shortmess+=I                " No welcome screen
set shortmess+=A                " No .swp warning
set history=256                 " Number of things to remember in history.
set timeoutlen=50               " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed          " Yanks go on clipboard instead.
set pastetoggle=<F10>           " Toggle between paste and normal: for 'safer' pasting from keyboard
set shiftround                  " round indent to mutiple of 'shiftwidth'
set tags=.git/tags;$HOME        " Consider the repo tags first, then walk directory tree upto $HOME
                                " looking for tags note `;` sets the stop folder. :h file -serch
set exrc                        " enable per-directory .vimrc files
set secure                      " disable unsafe commands in local .vimrc files

" }}}-------------------------------------------------------------------------
"   Visual                                                                {{{
" ----------------------------------------------------------------------------

" Control Area (May be superseded by vim-airline)
set showcmd                 " Show (partial) command in the last line of the screen.
set wildmenu                " Command completion
set wildmode=list:longest   " List all matches and complete till longest common string
set laststatus=2            " The last window will have a status line always
set noshowmode              " Don't show the mode in the last line of the screen, vim-airline takes care of it
set ruler                   " Show the line and column number of the cursor position, separated by a comma.
set lazyredraw              " Don't update the screen while executing macros/commands

" My command line autocomplete is case insensitive. Keep vim consistent with
" that. It's a recent feature to vim, test to make sure it's supported first.
if exists("&wildignorecase")
    set wildignorecase
endif

" Buffer Area Visuals
set scrolloff=7             " Minimal number of screen lines to keep above and below the cursor.
set visualbell              " Use a visual bell, don't beep!
set cursorline              " Highlight the current line
set number                  " Show line numbers
set wrap                    " Soft wrap at the window width
set linebreak               " Break the line on words
set textwidth=79            " Break lines at just under 80 characters
if exists('+colorcolumn')
  set colorcolumn=+1        " Highlight the column after `textwidth`
endif

" show fold column, fold by markers
set foldcolumn=0            " Don't show the folding gutter/column
set foldmethod=marker       " Fold on {{{ }}}
set foldlevelstart=20       " Open 20 levels of folding when I open a file

" Open folds under the following conditions
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo,jump

" Highlight tabs and trailing spaces
set listchars=tab:▸\ ,trail:•
set list                    " Make whitespace characters visible

" Splits
set splitbelow              " Open new splits below
set splitright              " Open new vertical splits to the right

" Function to trim trailing white space
" Make your own mappings
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Character meaning when present in 'formatoptions'
" ------ ---------------------------------------
" c Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" q Allow formatting of comments with "gq".
" r Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" t Auto-wrap text using textwidth (does not apply to comments)
" n Recognize numbered lists
" 1 Don't break line after one-letter words
" a Automatically format paragraphs
set formatoptions=cqrn1

" Colors
syntax enable               " This has to come after colorcolumn in order to draw it.
set t_Co=256                " enable 256 colors
colorscheme molokai

let g:airline_theme='zenburn'

" When completing, fill with the longest common string
" Auto select the first option
set completeopt=longest,menuone

" Printing options
set printoptions=header:0,duplex:long,paper:letter,syntax:n
" header:0                  Do not print a header
" duplex:long (default)     Print on both sides (when possible), bind on long
" syntax:n                  Do not use syntax highlighting.

" }}}-------------------------------------------------------------------------
"   Style for terminal vim
" ----------------------------------------------------------------------------

" Don't show the airline separators
" The angle bracket defaults look fugly
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline_powerline_fonts=0
set mouse+=a  " Add mouse support for 'all' modes, may require iTerm
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" }}}-------------------------------------------------------------------------
"   Search                                                                {{{
" ----------------------------------------------------------------------------

set incsearch               " Show search results as we type
set showmatch               " Show matching brackets
set hlsearch                " Highlight search results

" Use regex for searches
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
set ignorecase              " Ignore case when searching
set smartcase               " Don't ignore case if we have a capital letter

" }}}-------------------------------------------------------------------------
"   Tabs                                                                  {{{
" ----------------------------------------------------------------------------

set tabstop=4               " Show a tab as four spaces
set shiftwidth=4            " Reindent is also four spaces
set softtabstop=4           " When hit <tab> use four columns
set expandtab               " Create spaces when I type <tab>
set shiftround              " Round indent to multiple of 'shiftwidth'.
set autoindent              " Put my cursor in the right place when I start a new line
filetype plugin indent on   " Rely on file plugins to handle indenting

" }}}-------------------------------------------------------------------------

"   Custom commands                                                       {{{
" ----------------------------------------------------------------------------

" Edit the vimrc file
nmap <silent> <Leader>ev :vsplit $MYVIMRC<CR>
nmap <silent> <Leader>ez :vsplit $HOME/.zshrc<CR>
nmap <silent> <Leader>ep :vsplit $HOME/.vim/plug.vim<CR>
nmap <silent> <Leader>es :vsplit $HOME/.ssh/config<CR>
nmap <silent> <Leader>et :vsplit $HOME/.tmux.conf<CR>
nmap <silent> <Leader>sv :source $MYVIMRC<CR>
nmap <silent> <Leader>sp :source $HOME/.vim/plug.vim<CR>

" Faster save/quite/close
nmap <silent> <Leader>w :update<CR>
nmap <silent> <Leader>q :quit<CR>
nmap <silent> <Leader>c :bdelete<CR>
nmap <silent> <Leader>n :cnext<CR>
nmap <silent> <Leader>p :cprevious<CR>

" Trim trailing white space
nmap <silent> <Leader>t :call StripTrailingWhitespaces()<CR>

" Cd to the current file's directory
nnoremap <Leader>. :cd %:p:h<CR>:pwd<CR>

" Move current window to the far left using full height
nmap <silent> <Leader>h <C-w>H

" Clear search highlights
nnoremap <leader><space> :nohlsearch<cr>

nnoremap <leader>pp :%!python -m json.tool<cr>

nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap * #
" show/Hide hidden Chars
map <silent> <F12> :set invlist<CR>     
" generate HTML version current buffer using current color scheme
map <silent> <LocalLeader>2h :runtime! syntax/2html.vim<CR> 
""" Window splits key mapping
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h
" }}}-------------------------------------------------------------------------

" }}}-------------------------------------------------------------------------
"   Undo, Backup and Swap file locations                                  {{{
" ----------------------------------------------------------------------------

" Don't leave .swp files everywhere. Put them in a central place
set directory=$HOME/.vim/swapdir//
set backupdir=$HOME/.vim/backupdir//
if exists('+undodir')
    set undodir=$HOME/.vim/undodir
    set undofile
endif

" }}}-------------------------------------------------------------------------
"   If there is a per-machine local .vimrc, source it here at the end     {{{
" ----------------------------------------------------------------------------

if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" }}}-------------------------------------------------------------------------


