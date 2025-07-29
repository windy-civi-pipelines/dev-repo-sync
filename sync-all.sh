set -e

BRANCH_NAME=main
ORG=windy-civi-pipelines
FILE_TO_COPY=shared/time_utils.py
DEST_PATH=openstates_scraped_data_formatter/utils/timestamp_tracker.py

while IFS= read -r REPO_NAME; do
  echo "🔁 Syncing $REPO_NAME..."

  git clone "git@github.com:$ORG/$REPO_NAME.git"
  cd "$REPO_NAME"

  git checkout "$BRANCH_NAME"

  mkdir -p "$(dirname "$DEST_PATH")"
  cp "../$FILE_TO_COPY" "$DEST_PATH"

  git add "$DEST_PATH"
  git commit -m "fix: preserve skipped item files using category-prefixed filenames" || echo "⚠️ Nothing to commit for $REPO_NAME"
  git push origin "$BRANCH_NAME"

  cd ..
  rm -rf "$REPO_NAME"
done < repos.txt
