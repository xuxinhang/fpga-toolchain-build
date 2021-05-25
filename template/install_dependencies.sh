#!/usr/bin/env bash

case $ARCH in
'windows_x86')
	pacman -Sy mingw-w64-x86_64-gcc autoconf flex bison
	pacman -Sy libgz libfl2 libfl-dev zlibc zlib1g zlib1g-dev || :
	;;
'linux_x86')
	;;
esac

