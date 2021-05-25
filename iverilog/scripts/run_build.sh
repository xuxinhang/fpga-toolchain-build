#!/usr/bin/env bash

cd repo
autoconf && ./configure --prefix $TOOL_PKT_DIR
make
make test
make install
cd ..
