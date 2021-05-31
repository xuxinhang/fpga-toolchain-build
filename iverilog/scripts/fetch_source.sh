#!/usr/bin/env bash

if [ -e $TOOL_DIR_REPO ]
then
    git -C $TOOL_DIR_REPO clean -xdf
else
    git clone https://github.com/steveicarus/iverilog.git $TOOL_DIR_REPO --depth=10 -b v11-branch
fi
