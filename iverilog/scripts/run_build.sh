#!/usr/bin/env bash

cd $TOOL_DIR_REPO
autoconf && ./configure --prefix $TOOL_DIR_INSTALL
make
make test
make install
cd ..
