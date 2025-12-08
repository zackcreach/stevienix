---
model: opus
allowed-tools: Read, Grep, Glob, Bash
description: Complete a code review of the pending changes on the current branch
---

GIT STATUS:

```
!`git status`
```

FILES MODIFIED:

```
!`git diff --name-only origin/HEAD...`
```

COMMITS:

```
!`git log --no-decorate origin/HEAD...`
```

DIFF CONTENT:

```
!`git diff --merge-base origin/HEAD`
```

Review the complete diff above. This contains all code changes in the PR.

OBJECTIVE:
Use the code-review agent to comprehensively review the complete diff above, and reply back to the user with the review report. Your final reply must contain the markdown report and nothing else.
