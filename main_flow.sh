#!/usr/bin/env bash

# use pacman interface
mkdir -p /usr/local/bin
wget -O /usr/local/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
chmod 755 /usr/local/bin/pacapt
ln -sv /usr/local/bin/pacapt /usr/local/bin/pacman || true

# useful variables
SHORT_PACAPT_S='pacapt -S -y --needed --noconfirm '


export ARCH='windows-x86_64'

AVAILABLE_ARCHITECTURE=('windows-x86_64' 'windows-i686' 'linux-x86_64' 'linux-i386')

BUILD_LIST=(iverilog verilator)

export PROJ_ROOT_DIR=`pwd`

for t in ${BUILD_LIST[*]}
do
    cd $TOOL_ROOT_DIR
    echo '======= Flow Start: '$t' ======='
	export TOOL_NAME=$t
	export TOOL_ROOT_DIR=$PROJ_ROOT_DIR'/'$TOOL_NAME
    export TOOL_PKT_DIR=`pwd`/pkt
    export TOOL_REPO_DIR=`pwd`/repo
    export TOOL_TMP_DIR=`pwd`/tmp
	
	if [ -e tmp ]; then rm tmp -rf; fi
	mkdir tmp

    echo '>> Fetching source ...'
	if [ -e repo ]; then rm repo -rf; fi
    . ./scripts/fetch_source.sh
	
	if [ ! -d $REPO_DIR ]; then
		echo 'No source files.'
		continue
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
