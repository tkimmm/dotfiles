" Enabling filetype support provides filetype-specific indenting,
" syntax highlighting, omni-completion and other useful settings.
filetype plugin indent on
" syntax on
syntax enable

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


" packadd! vimspector
packloadall
:imap jk <Esc>

" Cursor mode customisations
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
autocmd VimLeave * let &t_me="\<Esc>]50;CursorShape=1\x7"

" Buffer navigation and options
nnoremap <silent> ( :bp<CR>
nnoremap <silent> ) :bn<CR>
nnoremap <silent> <C-q> :bd<CR>
nnoremap <silent> _ :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :Lines<CR>
nnoremap <silent> <S-f> :Files<CR>

" ALE Linting options
" let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
" let g:ale_set_highlights = 0

" Debugging navigation
nmap <silent> <C-a> :ALELint<CR>
nmap <silent> <C-x> :ALENext<CR>
nmap <silent> <C-z> :ALEPrevious<CR>

" set signcolumn=number
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
:set fillchars+=vert:\ 
set number relativenumber
highlight SignColumn guibg=NONE ctermbg=NONE
highlight EndOfBuffer ctermfg=blue ctermbg=blue
hi VertSplit guibg=NONE guifg=NONE ctermbg=NONE ctermfg=blue


" Markdown config
" let g:mkdp_browser = 'chrome'
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"
let g:mkdp_browser = 'Google Chrome'

" Insert line below without using insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

let g:vimspector_enable_mappings = 'HUMAN'

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Plug 'justinmk/vim-dirvish'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'"
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'

" List ends here. Plugins become visible to Vim after ithis call.
call plug#end()

" VIM Nerdtree
" autocmd StdinReadPre * let s:std_in=1 " if no file specified then open tree
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
let NERDTreeMinimalUI=1
" Otherwise can be done using (I)
" let g:NERDTreeShowHidden=1

" Fzf settings
let g:fzf_preview_window = ['down:50%', 'ctrl-/']
let g:fzf_layout = { 'right': '50%' } 

" Airline 
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
set noshowmode " removes double status line when using airline
