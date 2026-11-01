---
name: github-issue-fetcher
description: >-
  Fetches GitHub issue details (title, body, state, comments) from private or public repositories using the GitHub CLI REST API (`gh api`). Use this skill whenever the user provides a GitHub issue URL (e.g. `https://github.com/<owner>/<repo>/issues/<number>`) or asks to work on a numbered GitHub issue.
---

# GitHub Issue Fetcher

Quickly retrieve GitHub issue titles, descriptions, states, and comments—including from private repositories—without hitting deprecated GraphQL fields or unauthenticated 404 errors.

## Why Standard Approaches Fail

1. **Private Repository**: Unauthenticated `curl` or `search_web` requests return `404 Not Found` because the repository is private.
2. **Deprecated GraphQL Fields**: Running bare `gh issue view <number>` queries the deprecated Classic Projects GraphQL field (`repository.issue.projectCards`) on older `gh` CLI versions and exits with code 1.

## Fast One-Step Procedure

When given a GitHub issue URL like `https://github.com/<owner>/<repo>/issues/<number>` (or an issue number in the current repo):

### Option 1: Direct REST API Call via `gh api` (Fastest)

Run `gh api` against the REST endpoint to fetch the issue metadata and comments in a single command:

```bash
gh api repos/<owner>/<repo>/issues/<number> --jq '{number: .number, title: .title, state: .state, body: .body}' && \
gh api repos/<owner>/<repo>/issues/<number>/comments --jq '.[] | {author: .user.login, created_at: .created_at, body: .body}'
```

For the current repository, you can also use `{owner}/{repo}` placeholder expansion:

```bash
gh api 'repos/{owner}/{repo}/issues/<number>' --jq '{number: .number, title: .title, state: .state, body: .body}'
```

### Option 2: Helper Script

Run the bundled helper script [fetch_issue.sh](./scripts/fetch_issue.sh) with either a full GitHub issue URL or an issue number:

```bash
bash .agents/skills/github-issue-fetcher/scripts/fetch_issue.sh https://github.com/<owner>/<repo>/issues/<number>
```

### Option 3: `gh issue view` with Explicit `--json` Fields

If using `gh issue view`, always specify `--json` so `gh` skips the deprecated `projectCards` field:

```bash
gh issue view <number> --repo <owner>/<repo> --json number,title,state,body,comments
```
