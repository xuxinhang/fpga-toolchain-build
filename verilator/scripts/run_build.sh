#!/usr/bin/env bash

cd repo
autoconf && ./configure --prefix $PKT_OUTPUT_DIR
ln /usr/include/FlexLexer.h /mingw64/include -f
make
make test
make install
cd ..
