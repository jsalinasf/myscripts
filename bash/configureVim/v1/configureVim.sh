#!/bin/bash
file_location=~/.vimrc
cat > $file_location <<EOF
set nu
set ic
set ruler
set expandtab
set tabstop=2
EOF
fi
