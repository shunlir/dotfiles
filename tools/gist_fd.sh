#!/bin/bash

#
# install prebuit fd
#
set -e
mkdir -p /tmp/work
cd /tmp/work
wget https://github.com/sharkdp/fd/releases/download/v8.1.1/fd-v8.1.1-x86_64-unknown-linux-gnu.tar.gz
tar xf fd-v8.1.1-x86_64-unknown-linux-gnu.tar.gz
cd fd-v8.1.1-x86_64-unknown-linux-gnu
sudo cp -v fd /usr/local/bin
sudo cp -v fd.1 /usr/local/share/man/man1


rm -rf /tmp/work
