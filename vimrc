" Packages {{{

set shell=/usr/local/bin/zsh

" Required for Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'

call vundle#end()
filetype plugin indent on

" }}}

" The Essentials {{{

" Allow vim to determine the type of a file using its name and contents.
" Use this information for auto-indentation and any plugin that's filetype-specific.
filetype indent plugin on

" Enable syntax highlighting
syntax enable

" }}}

" Important Stuff {{{

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Better command-line completion.
set wildmenu
set wildmode=list:longest

" Show commands as we type them.
set showcmd

" Search incrementally with highlighting.
set hlsearch
set incsearch

" }}}

" Usability {{{

" Yank to clipboard
set clipboard=unnamed

" Make search case-insensitive iff there are no capital letters.
set ignorecase
set smartcase

" Allow backspace over autoindent, line breaks, and start of insert action.
set backspace=2

" If we have no filetype-specific indenting, use the current line's indent.
set autoindent

" Certain movements take us to the start of the line. This can be
" annoying.
set nostartofline

" Make splits open below and to the right rather than above and to the left.
set splitbelow
set splitright

" Set up the status line
" set ruler
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Always display the status line, even if there is only one window.
set laststatus=2

" Use a dialogue for unsaved changes, instead of a silent failure.
set confirm

" Use a visual bell instead of beeping.
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
" set t_vb=

" Allow the use of the mouse in all modes.
set mouse=a

" Set the command window height to two lines.
set cmdheight=2

" Display the absolute line number for the current line and relative
" line numbers for the rest.
set number
set relativenumber

" Highlight the current line.
" set cursorline

" Quickly time out on keycodes, but never time out on mappings.
set notimeout ttimeout ttimeoutlen=200

" Up the number of commands maintained in vim's history.
set history=1000

" Use English for spellchecking, but don't spell check by default.
set spl=en spell
set nospell

" Set line width and the default window width.
" set textwidth=76
" set columns=80

" }}}

" Indentation Options {{{

" Indentation settings for soft tabs.
set shiftwidth=4
set softtabstop=4
set expandtab

" Display trailing whitespace without an eol character.
" >-----... for a tab and ········... for spaces.
set listchars=tab:>-,trail:·
" set list

" }}}

" Aesthetics {{{

" Use Ethan Schoonover's Solarized colorscheme.
if has("gui_running")
    set background=light
else
    set background=dark
endif
colorscheme solarized

" Use Inconsolata in gui.
if has('gui_running') && has('unix')
    if system('uname') == "Darwin\n"
        set guifont=Inconsolata:h15
    else
        set guifont=Inconsolata\ 15
    endif
endif

" }}}

" Mappings {{{

" Make a comma the leader.
let mapleader = ","

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default.
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search.
nnoremap <C-L> :nohl<CR><C-L>

" Remap jj to <ESC> in insert mode.
inoremap jj <ESC>

" Swap ` and ' for jumping to marks. ` jumps to the correct line _and_
" column, which seems much more useful.
nnoremap ` '
nnoremap ' `

" Swap ; and :.
nnoremap : ;
nnoremap ; :

" Toggle whitespace display.
nnoremap <Leader>s :set list!<CR>

" }}}
