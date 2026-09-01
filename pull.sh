#!/bin/sh
# Server-side deploy script. Lives in the repo so the Hostinger cron command
# stays well under the 255-char API limit — the cron only needs to fetch and
# run this file.
set -e

DOCROOT="$HOME/domains/tkvibes.in/public_html/blogs"
REPO="https://github.com/takclawmachine-cpu/tkvibes-blogs-deploy.git"

cd "$DOCROOT"

if [ -d .git ]; then
  git fetch -q --depth 1 origin main
  git reset --hard origin/main
else
  git init -q
  git remote add origin "$REPO" 2>/dev/null || git remote set-url origin "$REPO"
  git fetch -q --depth 1 origin main
  git reset --hard origin/main
fi

echo "DEPLOYED $(git rev-parse --short HEAD)"
