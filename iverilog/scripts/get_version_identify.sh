version_desc="$(git -C $TOOL_DIR_REPO describe || echo '11.0')"
echo $version_desc
