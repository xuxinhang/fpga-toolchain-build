
cp -rf -T $TOOL_DIR_ROOT/chocolatey $TOOL_DIR_CHOCO
mkdir -p $TOOL_DIR_CHOCO/tools/_archieves

for arch in $(ls $TOOL_DIR_PACKAGE)
do
    echo "Zipping '$TOOL_NAME' for '$arch'"
    cd $TOOL_DIR_PACKAGE/$arch
    zip -q -r $TOOL_DIR_CHOCO/tools/_archieves/$arch.zip *
done

# replace version number
version_desc="$(git -C $TOOL_DIR_REPO describe || echo 'UNKNOWN')"
sed -i "s/__REPLACE_VERSION__/$version_desc/g" $TOOL_DIR_CHOCO/*.nuspec

# attach extra files
cp $TOOL_DIR_REPO/Changes    $TOOL_DIR_CHOCO/tools
cp $TOOL_DIR_REPO/README.rst $TOOL_DIR_CHOCO/tools
cp $TOOL_DIR_REPO/Artistic   $TOOL_DIR_CHOCO/tools
cp $TOOL_DIR_REPO/LICENSE    $TOOL_DIR_CHOCO/tools
