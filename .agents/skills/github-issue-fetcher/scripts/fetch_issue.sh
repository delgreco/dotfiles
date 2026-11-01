#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
    echo "Usage: $0 <github-issue-url-or-number>" >&2
    exit 1
fi

INPUT="$1"

if [[ "$INPUT" =~ github\.com/([^/]+)/([^/]+)/issues/([0-9]+) ]]; then
    OWNER="${BASH_REMATCH[1]}"
    REPO="${BASH_REMATCH[2]}"
    NUMBER="${BASH_REMATCH[3]}"
    ENDPOINT="repos/${OWNER}/${REPO}/issues/${NUMBER}"
elif [[ "$INPUT" =~ ^[0-9]+$ ]]; then
    NUMBER="$INPUT"
    ENDPOINT="repos/{owner}/{repo}/issues/${NUMBER}"
else
    echo "Error: Unrecognized issue URL or number: $INPUT" >&2
    exit 1
fi

echo "=== Issue Metadata ==="
gh api "$ENDPOINT" --jq '{number: .number, title: .title, state: .state, body: .body}'

echo "=== Issue Comments ==="
gh api "${ENDPOINT}/comments" --jq '.[] | {author: .user.login, created_at: .created_at, body: .body}'
