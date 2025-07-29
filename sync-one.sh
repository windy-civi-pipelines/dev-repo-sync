set -e

REPO_NAME=$1
BRANCH_NAME=fix/skipped-file-prefix
ORG=windy-civi-pipelines
FILE_TO_COPY=shared/time_utils.py
DEST_PATH=openstates_scraped_data_formatter/utils/timestamp_tracker.py

echo "🔁 Syncing $REPO_NAME..."

git clone "git@github.com:$ORG/$REPO_NAME.git"
cd "$REPO_NAME"

git checkout -b "$BRANCH_NAME"

mkdir -p "$(dirname "$DEST_PATH")"
cp "../$FILE_TO_COPY" "$DEST_PATH"

git add "$DEST_PATH"
git commit -m "fix: preserve skipped item files using category-prefixed filenames"
git push -u origin "$BRANCH_NAME"

# Optional: create a PR
gh pr create --title "Preserve skipped item filenames" \
  --body "This PR updates error handling to use category-prefixed filenames for skipped items." \
  --base main --head "$BRANCH_NAME"

cd ..
rm -rf "$REPO_NAME"
