#!/usr/bin/env bash
# The repo's checks. Exit 0 only when the branch is fit to review.
#
# The gate runs this script from the main checkout with the job's worktree as
# the working directory. Keep it fast, deterministic and non-interactive: no
# watch modes, no prompts, nothing that rewrites files (no --fix, no snapshot updates).
#
# Runs whatever the project has, in this order: Node scripts (lint, typecheck,
# test, build) and pytest. A fresh worktree has no node_modules, so it installs first.
set -euo pipefail

ran=0

if [ -f package.json ]; then
  has() { node -e "const s=require('./package.json').scripts||{}; process.exit(s['$1']?0:1)" 2>/dev/null; }
  if [ -f package-lock.json ]; then
    echo "▶ npm ci"; npm ci --prefer-offline --no-audit --no-fund
  else
    echo "▶ npm install"; npm install --no-audit --no-fund
  fi
  for s in lint typecheck test build; do
    if has "$s"; then echo "▶ npm run $s"; CI=1 npm run "$s"; ran=1; fi
  done
fi

if { [ -f pyproject.toml ] || [ -f requirements.txt ]; } && command -v pytest >/dev/null 2>&1; then
  echo "▶ pytest"; pytest -q; ran=1
fi

if [ "$ran" = 0 ]; then
  # Brand-new repo: nothing to check yet. Passing here means the gate proves nothing,
  # so add a "test" script (or other checks) as soon as the first feature lands.
  echo "WARNING: no checks found (no package.json scripts lint/typecheck/test/build, no pytest). Gate passes with nothing verified." >&2
fi
echo "checks: done"
