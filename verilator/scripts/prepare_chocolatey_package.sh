
cp -rf -T $TOOL_DIR_ROOT/chocolatey $TOOL_DIR_CHOCO
archive_path=$TOOL_DIR_CHOCO/tools/_archives
mkdir -p $archive_path
cp $TOOL_DIR_PACKAGE/*mingw*.* $archive_path

# replace version number
version_desc=$(echo $(git -C $TOOL_DIR_REPO describe --abbrev=0 || echo commit_$(git show --format="%h")) | sed 's/^v//')
sed -i "s/__REPLACE_VERSION__/$version_desc/g" $TOOL_DIR_CHOCO/*.nuspec
