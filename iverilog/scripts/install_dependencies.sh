#!/usr/bin/env bash

case $ARCH in
'windows-i686')
	pacman -S --noconfirm mingw-w64-i686-gcc
	pacman -S --noconfirm automake make autoconf gperf flex bison
	pacman -S --noconfirm libbz2 libbz2-devel
	;;
'windows-x86_64')
	pacman -S --noconfirm mingw-w64-x86_64-gcc
	pacman -S --noconfirm automake make autoconf gperf flex bison
	pacman -S --noconfirm libbz2 libbz2-devel
	;;
'linux_x86')
	;;
*)
	echo 'Unknown ARCH.'
esac

