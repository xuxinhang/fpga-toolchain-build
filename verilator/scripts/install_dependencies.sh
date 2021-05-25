#!/usr/bin/env bash

case $ARCH in
'windows_x86')
	pacman -S --noconfirm mingw-w64-x86_64-gcc # TODO
'windows_x64')
	pacman -S --noconfirm mingw-w64-x86_64-gcc
	pacman -S --noconfirm perl python3 make
	pacman -S --noconfirm autoconf flex bison
	pacman -S --noconfirm libgz libfl2 libfl-dev zlibc zlib1g zlib1g-dev || :
	;;
'linux_x86')
	;;
*)
	echo 'Unknown ARCH.'
esac

