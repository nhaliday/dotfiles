 " TODO Should look at this https://github.com/romainl/idiomatic-vimrc

set nocompatible
" Below added to make clicking on tabs work in tmux.
"set ttymouse=xterm2
" Tryng sgr instead because: https://stackoverflow.com/questions/7000960/in-vim-why-doesnt-my-mouse-work-past-the-220th-column
set ttymouse=sgr
set mouse=a

set autoindent

" https://stackoverflow.com/questions/4151448/spaces-as-tabs-and-backspace-behavior-in-vim
set tabstop=2
set shiftwidth=2
set expandtab
" Can't use the S-Tab mapping described above because S-Tab/Tab are remapped
" by YouCompleteMe (for navigating completion menu).

set backspace=indent,eol,start
" Adding unnamedplus seems to make things work more consistently in my current
" setting (PuTTY + tmux).
set clipboard=unnamedplus

filetype indent on
" Added the below line at the request of vimtex.
filetype plugin on
" Can't remember why I picked `syntax enable` over `syntax on`.
" syntax on
syntax enable

set foldmethod=indent
set foldlevel=99
" https://stackoverflow.com/questions/21633870/vim-folding-close-all-children-recursively-under-cursor
" If you think this is broken. It's probably not. Vim's semantics for
" folding are just somewhat counterintuitive:
" - If the block starts with a comment. You have to skip it. To close the
"   block you must start at the first non-comment, non-blank line
"   within the block, *excluding the header*.
nnoremap zcc zcVj:foldc!<CR>

set number

set hlsearch
set incsearch
set ignorecase
set smartcase

nnoremap ; :
vnoremap ; :
set wildmenu

" Just gonna use plain <Esc> for now. Muscle memory isn't trained to jj
" anyway and I might be able to find a better solution TODO.
"inoremap jj <Esc>
"vnoremap jj <Esc>

set ruler
set colorcolumn=76

set notimeout ttimeout ttimeoutlen=100

set nofixendofline

set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~

" This option could be a little dangerous/confusing if I don't have some
" constant indicator showing whether any buffer is dirty...
"set hidden

set directory^=~/.vim/swapfiles//
" backupdir and undor don't support full paths unfortunately
set backup
set backupdir^=~/.vim/backupfiles
autocmd BufWritePre * let &backupext = '-' . strftime("%Y%m%dT%T") . '~'
set undofile
set undodir^=~/.vim/undofiles

set autoread

nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <leader>dd "_dd
xnoremap <leader>dd "_dd
nnoremap <leader>c "_c
xnoremap <leader>c "_c
xnoremap <leader>p "_dP

if &shell =~# 'fish$'
  set shell=sh
endif

augroup AngleBrackets
  autocmd!
  autocmd FileType cpp set matchpairs+=<:>
augroup END

" Some stuff from 'The Pragmatic Programmer'
" EasyToChange?
let s:ETC_buffer_write_times = 0
function! s:HandleETC()
  let s:ETC_buffer_write_times += 1
  if s:ETC_buffer_write_times % 10 == 0
    echom 'ETC?'
  endif
endfunction
autocmd BufWritePost * call s:HandleETC()

call plug#begin('~/.vim/plugged')

Plug 'tmux-plugins/vim-tmux-focus-events'

Plug 'embear/vim-localvimrc'
let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 2

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'

Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-visualrepeat'
Plug 'inkarkat/vim-CountJump'
Plug 'inkarkat/vim-ConflictMotions'
Plug 'vim-scripts/diffwindow_movement'

" Doesn't seem to work.
"Plug 'kana/vim-textobj-user'
"Plug 'glts/vim-textobj-comment'

Plug 'easymotion/vim-easymotion'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

Plug 'tommcdo/vim-exchange'

Plug 'chaoren/vim-wordmotion'
let g:wordmotion_prefix = '<Leader>'

Plug 'scrooloose/nerdtree'
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :NERDTreeFind<CR>
Plug 'scrooloose/nerdcommenter'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
nnoremap <C-P> :Files<CR>
nnoremap <C-L> :Buffers<CR>
Plug 'kana/vim-altr'

Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

Plug 'simnalamburt/vim-mundo'
nmap <F7> :MundoToggle<CR>
"Plug 'mg979/vim-localhistory'

Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1

Plug 'google/vim-searchindex'

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

Plug 'w0rp/ale'

nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
nmap <silent> [e <Plug>(ale_previous_wrap_error)
nmap <silent> ]e <Plug>(ale_next_wrap_error)

let g:ale_c_parse_compile_commands = 0
let g:ale_c_parse_makefile = 0
let g:ale_cpp_clang_options = '-std=gnu++17 -Wall'
let g:ale_cpp_gcc_options = g:ale_cpp_clang_options
let g:ale_linters = {'cpp': []}

let g:ale_fixers = {'cpp': ['clang-format'], 'proto': ['clang-format']}
let g:ale_fix_on_save = 1

Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer'}
"let g:ycm_use_clangd = 0
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.;x
"py'
"Plug 'grailbio/bazel-compilation-database'

Plug 'wsdjeg/vim-fetch'

"Plug 'ludovicchabant/vim-gutentags'
"let g:gutentags_modules = ['ctags', 'cscope']
let g:gutentags_modules = ['ctags']
let g:gutentags_cache_dir = '~/.vim/tagfiles'


Plug 'machakann/vim-sandwich'
Plug 'andymass/vim-matchup'
Plug 'terryma/vim-multiple-cursors'

Plug 'morhetz/gruvbox'

call plug#end()

let g:easy_align_delimiters = {
      \ '%': { 'pattern': '%', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 }
      \}

set background=dark
colorscheme gruvbox
