echo "$(git -C $(dirname "${BASH_SOURCE[0]}")/../_repo describe || echo 'UNKNOWN_VERSION')"
