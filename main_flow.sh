#!/usr/bin/env bash

# Task Configuration
AVAILABLE_ARCHITECTURE=('mingw32-w64-x86_64' 'mingw32-w64-i686' 'linux-x86_64' 'linux-i686')
_BUILD_LIST=('iverilog' 'verilator')

if [[ ! $ARCH ]]
then
    echo 'Must provide ARCH.'
    exit 1
fi

export BUILD_LIST=${BUILD_LIST-${_BUILD_LIST[*]}}


# use pacman interface
if [ -z $(which pacapt) ]
then
    mkdir -p /usr/local/bin
    wget -O /usr/local/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
    chmod 755 /usr/local/bin/pacapt
    ln -sv /usr/local/bin/pacapt /usr/local/bin/pacman || true
fi

SHORT_PACAPT_S='pacapt -S -y --needed --noconfirm '

. ./utils.sh


# Task Start
export PROJ_ROOT_DIR=`pwd`

for t in ${BUILD_LIST[*]}
do
    echo '======= Flow Start: '$t' ======='
    export TOOL_NAME=$t
    export TOOL_ROOT_DIR=$PROJ_ROOT_DIR'/'$TOOL_NAME
    export TOOL_PKT_DIR=$TOOL_ROOT_DIR/pkt
    export TOOL_REPO_DIR=$TOOL_ROOT_DIR/repo
    export TOOL_TMP_DIR=$TOOL_ROOT_DIR/tmp
    cd $TOOL_ROOT_DIR

    if [ -e tmp ]; then rm tmp -rf; fi
    mkdir tmp

    echo '>> Fetching source ...'
    cd $TOOL_ROOT_DIR
    if [ ! -e repo ]
    then
        rm -rf repo
        . ./scripts/fetch_source.sh
    fi

    echo '>> Installing dependencies ...'
    cd $TOOL_ROOT_DIR && . ./scripts/install_dependencies.sh

    echo '>> Building ...'
    if [ -e pkt ]; then rm pkt -rf; fi
    mkdir pkt
    cd $TOOL_ROOT_DIR && . ./scripts/run_build.sh

    echo '>> Testing ...'
    cd $TOOL_ROOT_DIR && . ./scripts/run_test.sh

    echo '>> Bundling ...'
    cd $TOOL_ROOT_DIR && true

    echo '======= Flow End  : '$t' ======='
done
