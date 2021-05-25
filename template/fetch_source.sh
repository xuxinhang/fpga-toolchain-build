#!/usr/bin/env bash

git clone https://github.com/verilator/verilator $REPO_DIR --depth=1
git clone https://github.com/steveicarus/iverilog.git $REPO_DIR --depth=1 -b v11-branch
