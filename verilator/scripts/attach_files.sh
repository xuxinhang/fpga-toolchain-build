
# attach docs files
docs_dir_path=$TOOL_DIR_INSTALL/docs
mkdir -p $docs_dir_path
cp -f $TOOL_DIR_REPO/{Changes,README.rst,Artistic,LICENSE} $docs_dir_path


case $ARCH in
'mingw32-w64-i686'|'mingw32-w64-x86_64')
    # attach msys dlls
    install_ntldd $ARCH
    dlls=''
    for sf in $(find $TOOL_DIR_INSTALL/bin -type f)
    do
        dlls="$dlls $(get_msys_dlls $sf)"
    done
    echo $dlls
    cp -f $dlls $TOOL_DIR_INSTALL/bin

    # create execuable slims for windows
    for e in $(find $TOOL_DIR_INSTALL/bin -type f -not -name '*.*')
    do
        generate_win_bat_slim $e $TOOL_DIR_INSTALL/bin
    done
    ;;
esac

