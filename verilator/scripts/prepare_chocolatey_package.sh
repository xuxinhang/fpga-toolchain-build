
cp -rf -T $TOOL_DIR_ROOT/chocolatey $TOOL_DIR_CHOCO
archive_path=$TOOL_DIR_CHOCO/tools/_archives
mkdir -p $archive_path
cp $TOOL_DIR_PACKAGE/*mingw*.* $archive_path
cp $TOOL_DIR_REPO/LICENSE $TOOL_DIR_CHOCO/tools/LICENSE.txt

# replace version number
version_desc=$(echo $(git -C $TOOL_DIR_REPO describe --abbrev=0 || echo commit_$(git show --format="%h")) | sed 's/^v//')
sed -i "s/__REPLACE_VERSION__/$version_desc/g" $TOOL_DIR_CHOCO/*.nuspec
release_tag=$(get_release_tag $TOOL_NAME $(source ./scripts/get_version_identify.sh))
sed -i "s/__RELEASE_TAG_NAME__/$release_tag/g" $TOOL_DIR_CHOCO/tools/VERIFICATION.txt
