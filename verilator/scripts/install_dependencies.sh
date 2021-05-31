#!/usr/bin/env bash

$SHORT_PACAPT_S perl python3 make
$SHORT_PACAPT_S autoconf flex bison
$SHORT_PACAPT_S libgz libfl2 libfl-dev zlibc zlib1g zlib1g-dev || :

setup_gcc $ARCH
