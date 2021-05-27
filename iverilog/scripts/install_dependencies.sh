#!/usr/bin/env bash

case $ARCH in
'windows-i686')
	$SHORT_PACAPT_S mingw-w64-i686-gcc
	$SHORT_PACAPT_S automake make autoconf gperf flex bison
	$SHORT_PACAPT_S libbz2 libbz2-devel
	;;
'windows-x86_64')
	$SHORT_PACAPT_S mingw-w64-x86_64-gcc
	$SHORT_PACAPT_S automake make autoconf gperf flex bison
	$SHORT_PACAPT_S libbz2 libbz2-devel
	;;
'linux_x86')
	;;
*)
	echo 'Unknown ARCH.'
esac

