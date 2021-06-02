
setup_gcc () {
    ARCH=$1
    # DO_INSTALL=${$1:-1}
    # DO_SETENV=${$2:-1}
    case $ARCH in
    'mingw32-w64-i686')
        $SHORT_PACAPT_S mingw-w64-i686-gcc
        export CC="i686-w64-mingw32-gcc"
        export CXX="i686-w64-mingw32-g++"
        ;;
    'mingw32-w64-x86_64')
        $SHORT_PACAPT_S mingw-w64-x86_64-gcc
        export CC="x86_64-w64-mingw32-gcc"
        export CXX="x86_64-w64-mingw32-g++"
        ;;
    'linux-i686')
        $SHORT_PACAPT_S gcc
        export CC='gcc -m32'
        export CXX='g++ -m32'
        ;;
    'linux-x86_64')
        $SHORT_PACAPT_S gcc
        export CC='gcc -m64'
        export CXX='g++ -m64'
        ;;
    *)
        echo 'Unknown ARCH.'
    esac
}

refresh_directory () {
    DIR=$1
    FORCE=$2
    if [[ -e $DIR ]]
    then
        if [[ $FORCE -gt 0 ]]
        then
            rm -rf $DIR
            mkdir $DIR
        fi
    else
        mkdir $DIR
    fi
}

