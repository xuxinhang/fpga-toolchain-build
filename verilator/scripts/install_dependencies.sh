#!/usr/bin/env bash

case $ARCH in
'windows_x86')
	$SHORT_PACAPT_S mingw-w64-x86_64-gcc # TODO
'windows_x64')
	$SHORT_PACAPT_S mingw-w64-x86_64-gcc
	$SHORT_PACAPT_S perl python3 make
	$SHORT_PACAPT_S autoconf flex bison
	$SHORT_PACAPT_S libgz libfl2 libfl-dev zlibc zlib1g zlib1g-dev || :
	;;
'linux_x86')
	;;
*)
	echo 'Unknown ARCH.'
esac

