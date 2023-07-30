#!/bin/bash
file_location=~/.vimrc
cat > $file_location <<EOF
set nu
set ic
set ruler
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set nowrap
set autoindent
set smartindent
set backspace=eol, indent,start
EOF