" Begin .vimrc

" === Plugin Management ===
" Use vim-plug as the plugin manager
call plug#begin('~/.vim/plugged')

" Core Plugins
Plug 'junegunn/vim-plug'                " Plugin manager
Plug 'preservim/nerdtree'               " File tree sidebar
Plug 'vim-airline/vim-airline'          " Status line with enhancements
Plug 'sheerun/vim-polyglot'             " Syntax highlighting for multiple languages
Plug 'tpope/vim-fugitive'               " Git integration
Plug 'jiangmiao/auto-pairs'             " Auto-closing for brackets and quotes

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                 " Fuzzy finder integration

" Color Scheme
Plug 'morhetz/gruvbox'                  " Gruvbox color scheme

" Python Development
Plug 'psf/black', { 'branch': 'stable' } " Auto-format Python code
Plug 'nvie/vim-flake8'                  " Python linting with Flake8
Plug 'junegunn/vim-plug'
Plug 'davidhalter/jedi-vim'  " Jedi for Python autocompletion

" C/C++ Development
Plug 'octol/vim-cpp-enhanced-highlight' " Enhanced C/C++ syntax highlighting
Plug 'vim-jp/vim-cpp'
Plug 'rip-rip/clang_complete'

" Rust Development
Plug 'rust-lang/rust.vim'               " Rust syntax highlighting and auto-formatting

" Finish plugin setup
call plug#end()

" === General Settings ===
syntax on                               " Enable syntax highlighting
filetype plugin indent on               " Enable file type detection and plugins
set number                              " Show absolute line numbers
set relativenumber                      " Show relative line numbers
set tabstop=4                           " Set tab width to 4 spaces
set shiftwidth=4                        " Set indentation width to 4 spaces
set expandtab                           " Convert tabs to spaces
set autoindent                          " Enable automatic indentation
set clipboard=unnamedplus               " Use system clipboard
set mouse=a                             " Enable mouse support
set wrap                                " Enable word wrapping
set cursorline                          " Highlight the current line
set scrolloff=5                         " Keep 5 lines above/below the cursor
set background=dark                     " Use dark background for theme
set showmode                            " Show mode in the command line
set laststatus=2                        " Always show the status line

" === Color Scheme ===
let g:gruvbox_contrast_dark = 'medium'  " Set Gruvbox contrast level
let g:gruvbox_invert_selection = '0'    " Do not invert selection
colorscheme gruvbox                     " Apply Gruvbox color scheme

" === Keybindings ===
let mapleader = " "                     " Set leader key to space

" File Explorer
nnoremap <leader>e :NERDTreeToggle<CR>  " Toggle NERDTree with <leader>e

" Fuzzy Finder
nnoremap <leader>f :Files<CR>           " Fuzzy search files with <leader>f
nnoremap <leader>b :Buffers<CR>         " Fuzzy search buffers with <leader>b

" Window Management
nnoremap <leader>v :vsplit<CR>          " Vertical split
nnoremap <leader>h :split<CR>           " Horizontal split
nnoremap <leader>q :q<CR>               " Close the current window

" === Auto-Pairing Brackets and Quotes ===
let g:AutoPairsFlyMode = 1              " Enable flying pairs mode

" === Python Development ===
autocmd BufWritePre *.py :Black         " Auto-format Python code on save
let g:flake8_show_in_gutter = 1         " Show linting errors in the gutter
let g:flake8_show_quickfix = 1          " Show linting errors in the quickfix list

" === C/C++ Development ===
autocmd FileType c,cpp nnoremap <leader>cf :%!clang-format<CR> " Format C/C++ with clang-format

" === Rust Development ===
let g:rustfmt_autosave = 1              " Auto-format Rust code on save
nnoremap <leader>rr :w<CR>:!cargo run<CR>  " Save and run Rust program
nnoremap <leader>rb :w<CR>:!cargo build<CR> " Save and build Rust program

" === Quickfix and Error Navigation ===
nnoremap <leader>cn :cnext<CR>          " Go to the next error
nnoremap <leader>cp :cprev<CR>          " Go to the previous error
nnoremap <leader>co :copen<CR>          " Open the quickfix list
nnoremap <leader>cc :cclose<CR>         " Close the quickfix list

" === Status Line Enhancements ===
let g:airline_powerline_fonts = 1       " Use powerline fonts for Vim-Airline
let g:airline_theme = 'gruvbox'         " Match status line with Gruvbox theme

" === Productivity Enhancements ===
set undofile                           " Enable persistent undo
set incsearch                          " Show incremental search results
set hlsearch                           " Highlight search matches
set ignorecase                         " Ignore case when searching
set smartcase                          " Override ignorecase if uppercase is used

" End of .vimrc

