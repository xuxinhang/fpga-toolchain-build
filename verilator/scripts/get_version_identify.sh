version_desc="$(git -C $TOOL_DIR_REPO describe || echo 'UNKNOWN_VERSION')"
echo $version_desc
