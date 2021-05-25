#!/usr/bin/env bash

cp ./scripts/*.?v ./tmp 
cd tmp

../pkt/bin/iverilog -tnull -g2005-sv testcase_a.sv
