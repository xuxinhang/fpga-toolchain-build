#!/usr/bin/env bash

cp ./scripts/*.?v $TOOL_DIR_TMP
cd $TOOL_DIR_TMP

$TOOL_DIR_INSTALL/bin/iverilog -tnull -g2005-sv testcase_a.sv
