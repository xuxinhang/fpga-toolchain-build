#!/usr/bin/env bash

# Task Configuration
AVAILABLE_ARCHITECTURE=('mingw32-w64-x86_64' 'mingw32-w64-i686' 'linux-x86_64' 'linux-i686')

_BUILD_TOOLS=('iverilog' 'verilator')
_BUILD_ARCHS=('mingw32-w64-i686' 'mingw32-w64-x86_64')

BUILD_TOOLS=${BUILD_TOOLS-${_BUILD_TOOLS[*]}}
BUILD_ARCHS=${BUILD_ARCHS-${_BUILD_ARCHS[*]}}

PROJ_ROOT_DIR=$(pwd)


# Utilities

# use pacman style interface
if [ -z $(which pacapt) ]
then
    mkdir -p /usr/local/bin
    wget -O /usr/local/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
    chmod 755 /usr/local/bin/pacapt
    ln -sv /usr/local/bin/pacapt /usr/local/bin/pacman || true
fi

# universal pacman shortcut
SHORT_PACAPT_S='pacapt -S -y --needed --noconfirm '

# others
. ./utils.sh


# Task Start
for TOOL_NAME in ${BUILD_TOOLS[*]}
do
    TOOL_DIR_ROOT=$PROJ_ROOT_DIR'/'$TOOL_NAME
    cd $TOOL_DIR_ROOT

    TOOL_DIR_INSTALL=$TOOL_DIR_ROOT/_install
    TOOL_DIR_REPO=$TOOL_DIR_ROOT/_repo
    TOOL_DIR_TMP=$TOOL_DIR_ROOT/_tmp
    TOOL_DIR_PACKAGE=$TOOL_DIR_ROOT/_package

    refresh_directory $TOOL_DIR_PACKAGE 0

    for ARCH in ${BUILD_ARCHS[*]}
    do
        echo ''
        echo 'BUILD START >>==============='
        echo "  $TOOL_NAME  ($ARCH)"
        echo '============================='
        echo ''
        refresh_directory $TOOL_DIR_INSTALL 1
        refresh_directory $TOOL_DIR_TMP 1

        echo '>> Fetching source ...'
        cd $TOOL_DIR_ROOT
        . ./scripts/fetch_source.sh

        echo '>> Installing dependencies ...'
        cd $TOOL_DIR_ROOT
        . ./scripts/install_dependencies.sh

        echo '>> Building ...'
        cd $TOOL_DIR_ROOT
        . ./scripts/run_build.sh

        echo '>> Testing ...'
        cd $TOOL_DIR_ROOT
        . ./scripts/run_test.sh

        echo '>> Moving ...'
        cd $TOOL_DIR_ROOT
        refresh_directory $TOOL_DIR_PACKAGE'/'$ARCH 1
        cp -rfT $TOOL_DIR_INSTALL $TOOL_DIR_PACKAGE'/'$ARCH

        echo ''
        echo 'BUILD FINISHED >>============'
        echo ''
    done
done
