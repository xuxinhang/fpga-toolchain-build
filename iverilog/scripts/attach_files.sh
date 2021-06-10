
# attach docs files
docs_dir_path=$TOOL_DIR_INSTALL/docs
mkdir -p $docs_dir_path
cp -f $TOOL_DIR_REPO/{COPYING,README.txt,QUICK_START.txt,BUGS.txt} $docs_dir_path


# attach msys dlls
case $ARCH in
'mingw32-w64-i686'|'mingw32-w64-x86_64')
    dlls=''
    for sf in $(find $TOOL_DIR_INSTALL/{bin,lib} -type f)
    do
        dlls="$dlls $(get_msys_dlls $sf)"
    done
    echo $dlls
    cp -f $dlls $TOOL_DIR_INSTALL/bin
    cp -f $dlls $TOOL_DIR_INSTALL/lib/ivl
    ;;
esac
