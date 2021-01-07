" Enabling filetype support provides filetype-specific indenting,
" syntax highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on

" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" various settings
set autoindent                 " Minimal automatic indenting for any filetype.
set backspace=indent,eol,start " Proper backspace behavior.
set hidden                     " Possibility to have more than one unsaved buffers.
set incsearch                  " Incremental search, hit `<CR>` to stop.
set ruler                      " Shows the current line number at the bottom-right
                               " of the screen.
set wildmenu                   " Great command-line completion, use `<Tab>` to move
                               " around and `<CR>` to validate.
set number relativenumber

syntax enable
filetype plugin indent on

packadd! vimspector
packloadall
:imap jk <Esc>

" Buffer navigation and options
nnoremap <silent> ( :bp<CR>
nnoremap <silent> ) :bn<CR>	
nnoremap <silent> <C-q> :bd<CR>
nnoremap <silent> _ :BufExplorer<CR>

let g:vimspector_enable_mappings = 'HUMAN'

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'justinmk/vim-dirvish'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" List ends here. Plugins become visible to Vim after ithis call.
call plug#end()

