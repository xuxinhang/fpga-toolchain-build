
_BUILD_TOOLS='iverilog verilator'
BUILD_TOOLS=${BUILD_TOOLS-${_BUILD_TOOLS[*]}}

PROJ_ROOT_DIR=$(pwd)

. ./utils.sh

for TOOL_NAME in ${BUILD_TOOLS[*]}
do
    echo ">> Bundling Chocolatey Package ($TOOL_NAME)"
    TOOL_DIR_ROOT=$PROJ_ROOT_DIR/$TOOL_NAME
    TOOL_DIR_REPO=$TOOL_DIR_ROOT/_repo
    TOOL_DIR_PACKAGE=$TOOL_DIR_ROOT/_package
    TOOL_DIR_CHOCO=$TOOL_DIR_ROOT/_choco
    refresh_directory $TOOL_DIR_CHOCO 1
    cd $TOOL_DIR_ROOT

    echo '>> Preparing Files ...'
    cd $TOOL_DIR_ROOT
    . ./scripts/prepare_chocolatey_package.sh

    echo '>> Packing ...'
    cd $TOOL_DIR_CHOCO
    choco pack $TOOL_DIR_CHOCO/*.nuspec
done
