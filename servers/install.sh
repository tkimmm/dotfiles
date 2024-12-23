#!/bin/sh

# Check if Vim is installed
if command -v vim >/dev/null 2>&1; then
  # Create .vimrc
  cat >~/.vimrc <<EOL
set relativenumber
set number
inoremap jk <Esc>
nnoremap _ :Ex<CR>
nnoremap <silent> <C-q> :bd<CR>
EOL
  echo "Vim configuration has been set up successfully."
fi

# Check if Neovim is installed
if command -v nvim >/dev/null 2>&1; then
  # Create .config/nvim/init.vim
  mkdir -p ~/.config/nvim
  cat >~/.config/nvim/init.vim <<EOL
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOL
  echo "Neovim configuration has been set up successfully."
else
  echo "Neovim is not installed. Skipping Neovim configuration."
fi
