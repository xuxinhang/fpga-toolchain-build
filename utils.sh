
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
        export LD='ld -melf_i386'
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


get_msys_dlls () {
    file_path=$1
    win_root_path=$SYSTEMROOT
    paths=$(ntldd -R $file_path | grep '=>' | grep --invert-match 'not found' | grep --invert-match $(echo $win_root_path | sed 's/\\/\\\\/') | sed -E 's/\s*?(.*?) => (.*?) \(.*?\)/\2/')
    echo $paths
}


generate_win_bat_slim () {
    file_path=$1
    work_path=${2-`pwd`}
    file_rela=$(realpath --relative-to=$work_path $file_path)
    if [[ $(head -c2 $file_path) = '#!' ]]
    then
        interpreter=$(echo $(head -n1 $file_path) | sed -E 's/.*\/(env\s*|)(.*?)$/\2/')
        echo '@'$interpreter' %~dp0\'$(echo $file_rela | sed 's/\//\\/g')' %*' >> $work_path/$(basename $file_path).bat
    fi
}
