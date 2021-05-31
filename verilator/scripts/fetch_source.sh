#!/usr/bin/env bash

if [ -e $TOOL_DIR_REPO ]
then
    git -C $TOOL_DIR_REPO clean -xdf
else
    git clone https://github.com/verilator/verilator $TOOL_DIR_REPO --depth=50 -b stable
fi
