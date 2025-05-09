#!/usr/bin/env bash
#
# can-auto-merge.sh
#
# Checks if pushed changes only contain edits to the users/{name}.nix file
# that is owned by the user who made the push. If the commit has any other
# changed files, or if the `githubId` attribute has been modified, the changes
# cannot be automatically merged and must be reviewed.

set -eou pipefail

cannot_auto_merge() {
  echo "❌ Cannot auto-merge"
  exit 1
}

if grep -qxF "$GITHUB_ID" timeout-corner; then
  echo "User is in timeout."
  cannot_auto_merge
fi

status=$(git diff --name-only "$PREV_HASH" "$CURR_HASH")
num_files_changed=$(echo "$status" | wc -l)

echo "$status"
echo "Number of files changed: $num_files_changed"

if [ "$num_files_changed" -eq 1 ]; then
  file_changed="$status"

  if echo "Modified: $file_changed" | grep users; then
    prev_github_id=$(nix eval --json --expr "$(git show "$PREV_HASH:$file_changed").githubId")
    curr_github_id=$(nix eval --json --expr "$(git show "$CURR_HASH:$file_changed").githubId")

    echo "Previous GitHub ID: $prev_github_id"
    echo "Current GitHub ID: $curr_github_id"
    echo "GHA GitHub ID: $GITHUB_ID"

    if [ "$curr_github_id" -eq "$GITHUB_ID" ] && [ "$curr_github_id" -eq "$prev_github_id" ]; then
      echo "✅ Can auto-merge"
      exit 0
    fi
  fi
fi

cannot_auto_merge
