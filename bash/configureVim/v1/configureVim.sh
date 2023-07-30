#!/bin/bash
file_location=~/.vimrc
if [ -e $policy ]; then
  echo "File $1.json already exists!"
else
  cat > $file_location <<EOF
set nu
set ic
set ruler
set expandtab
set tabstop=2
EOF
fi
