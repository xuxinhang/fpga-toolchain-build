#!/usr/bin/env bash

cd $TOOL_DIR_REPO
autoconf && ./configure --prefix $TOOL_DIR_INSTALL

case $ARCH in
'mingw32-w64-i686')
    ln -f /usr/include/FlexLexer.h /mingw64/include
    ;;
'mingw32-w64-x86_64')
    ln -f /usr/include/FlexLexer.h /mingw32/include
    ;;
esac

make
make test
make install
cd ..
