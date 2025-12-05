---
model: opus
allowed-tools: Bash, Read, Glob, Grep
description: Restore context from previous conversations by reading relevant logs and git diff
---

You are restoring context from a previous conversation session. Your goal is to help the user catch up on where they left off.

CURRENT BRANCH:

```
!`git rev-parse --abbrev-ref HEAD`
```

AVAILABLE LOG FILES:

```
!`ls -la .claude/logs/ 2>/dev/null || echo "No .claude/logs directory found"`
```

MAIN BRANCH:

```
!`git remote show origin 2>/dev/null | grep 'HEAD branch' | awk '{print $NF}' || echo "main"`
```

FILES MODIFIED ON THIS BRANCH:

```
!`git diff --name-only origin/HEAD... 2>/dev/null || git diff --name-only main... 2>/dev/null || echo "No changes detected"`
```

COMMITS ON THIS BRANCH:

```
!`git log --oneline origin/HEAD... 2>/dev/null || git log --oneline main... 2>/dev/null || echo "No commits"`
```

DIFF CONTENT:

```
!`git diff --merge-base origin/HEAD 2>/dev/null || git diff --merge-base main 2>/dev/null || echo "No diff available"`
```

INSTRUCTIONS:

1. Extract the current branch name from above
2. Search ./.claude/logs/ for files matching:
   - Exact branch name (e.g., `CE-4574-add-emaillogs-table.md` for branch `CE-4574-add-emaillogs-table`)
   - Keywords from the branch name (e.g., search for "email" or "mailgun" if branch contains those terms)
3. Read all matching log files thoroughly
4. Analyze the git diff to understand current code changes
5. Provide a concise summary that includes:
   - What task/feature was being worked on
   - What has been completed (based on log checklists and commits)
   - What remains to be done (unchecked items, pending work)
   - Any blockers or issues noted in the logs
   - Recommended next steps to continue the work

Start by using Glob to find matching log files in ./.claude/logs/, then Read those files, and finally provide your context restoration summary.
