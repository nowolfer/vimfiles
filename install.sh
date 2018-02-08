#!/bin/bash

echo "Initial ... some plugins may installed"

vim -E -s dummy.out <<EOF
:source ~/.vim/vimrc
:PlugInstall
:PlugClean
:qa
EOF
