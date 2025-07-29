# Windy Civi Multi-Repo Sync Tool

This repo contains a lightweight script for syncing file updates across all Open States pipeline repos under the `windy-civi-pipelines` GitHub organization.

## 📦 Purpose

Many Windy Civi repos use identical logic for tasks like timestamp comparison and error handling. This tool lets you update one source file (like `timestamp_tracker.py`) and push that change to all downstream repos automatically.

## 🛠️ Usage

### 1. Add your source file

Put your shared file in:

```
shared/time_utils.py
```

This is the "golden copy" that will be copied into every target repo.

### 2. List target repos

Add repo names (just the suffix, not the full URL) to:

```
repos.txt
```

Example:

```
gu-data-pipeline
ma-data-pipeline
az-data-pipeline
```

### 3. Run the sync

To update **all** repos directly to `main`, run:

```bash
./sync-all.sh
```

Or to test one first:

```bash
./sync-one.sh gu-data-pipeline
```

Each script will:

- Clone the repo
- Copy in the file
- Commit the change
- Push directly to `main`
- Clean up the local clone

### 4. Requirements

- GitHub CLI (`gh`) – [Install guide](https://cli.github.com/)
- `jq` (for parsing JSON) – `brew install jq`
- SSH access to the repos

---

## 🔄 File locations

These are set inside the scripts:

| Variable       | Path                                                           |
| -------------- | -------------------------------------------------------------- |
| `FILE_TO_COPY` | `shared/time_utils.py`                                         |
| `DEST_PATH`    | `openstates_scraped_data_formatter/utils/timestamp_tracker.py` |

Adjust `DEST_PATH` if the file lives elsewhere in the target repos.

---

## 🙌 Contributing

Feel free to open PRs to improve this tool or add support for PR creation, dry-run mode, or selective repo filtering by status.

---

Made with ❤️ by the Windy Civi team.
