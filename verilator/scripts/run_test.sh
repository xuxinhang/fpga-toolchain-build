#!/usr/bin/env bash

cp ./scripts/*.?v ./tmp
cd tmp

../pkt/bin/verilator --lint-only testcase_a.sv
