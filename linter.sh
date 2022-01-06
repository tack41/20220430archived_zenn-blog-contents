#!/usr/env bash
set -euo pipefail

#SCRIPT_NAME=$(basename "$0")
CURRENT_DIR_RELATIVE=$(dirname "$0")
CURRENT_DIR=$(cd "$CURRENT_DIR_RELATIVE" || exit;pwd)
#PARENT_DIR=$(cd "$CURRENT_DIR"/.. || exit;pwd)
#GRANDPARENT_DIR=$(cd "$PARENT_DIR"/.. || exit;pwd)

pushd "$CURRENT_DIR" >/dev/null || exit 1

targetFile="./site.yml"
if [ -f "$targetFile" ]; then
  command -v ansible-lint >/dev/null &&:; rc=$?
  if [ "0" = "$rc" ]; then
    echo "[Start linter for ansible]"
    ansible-lint "$targetFile" &&:
    echo "[End linter for ansible]"
  else
    echo "ansible-lint command is not exists. Skipping..."
  fi
fi

targetFile="./docker-compose.yml"
if [ -f "$targetFile" ]; then
  command -v docker-compose >/dev/null &&:;rc=$?
  if [ "0" = "$rc" ];then
    echo "[Start linter for docker-compose.yml]"
    docker-compose -f "$targetFile" config -q &&:
    echo "[End linter for ansible]"
  else
    echo "docker-compose command is not exists. Skipping..."
  fi
fi

fileCount=$(find . -name "*.sh" -type f -not -path "*/node_modules/*" -not -path "*/.git/*"| wc -l)
if [ "0" != "$fileCount" ]; then
  command -v shellcheck >/dev/null &&:; rc=$?
  if [ "$rc" = "0" ]; then
    echo "[Start linter for bash]"
    find . -name "*.sh" -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -exec shellcheck -x {} \; &&:
    echo "[End linter for bash]"
  else
    echo "Shellcheck command isn't exists. please check online.(https://www.shellcheck.net/)"
    echo "Target files are below"
    echo ""
    find . -name "*.sh" -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -print
  fi
fi

fileCount=$(find . -name "*.md" -type f -not -path "*/node_modules/*" | wc -l)
if [ "0" != "$fileCount" ]; then
  npx markdownlint --version >/dev/null 2>&1 &&:; rc=$?
  if [ "$rc" = "0" ]; then
    echo "[Start linter for markdown]"
    npx markdownlint '**/*.md' --ignore node_modules &&:
    echo "[End linter for markdown]"
  else
    echo "markdownlint command isn't exists. please check online.(https://dlaa.me/markdownlint/)"
    echo "Target files are below"
    echo ""
    find . -name "*.md" -type f -not -path "*/node_modules/*"
  fi
fi

popd >/dev/null || exit 1
exit 0