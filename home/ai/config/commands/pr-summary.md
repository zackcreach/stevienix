---
model: opus
allowed-tools: Bash, Read, Glob, Grep
description: Generate a PR description from git history and logs
---

You are generating a pull request description. Your goal is to create a conversational, high-level summary suitable for copy/pasting directly into GitHub.

CURRENT BRANCH:

```
!`git rev-parse --abbrev-ref HEAD`
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

AVAILABLE LOG FILES:

```
!`ls -la .claude/logs/ 2>/dev/null || echo "No .claude/logs directory found"`
```

INSTRUCTIONS:

1. Extract the current branch name from above
2. Search ./.claude/logs/ for files matching the branch name or keywords from the branch
3. Read matching log files to understand the original intent and goals
4. Analyze the commits and modified files to understand what was accomplished

OUTPUT FORMAT:

Output ONLY the PR description in this exact format (ready for copy/paste into GitHub):

```
[1-2 sentence high-level overview of what this branch accomplishes and why]

- [Key change 1: what file/area and why it was changed]
- [Key change 2: what file/area and why it was changed]
- [Additional bullet points as needed]
```

GUIDELINES:

- Keep the overview conversational and focused on the "what" and "why"
- Bullet points should use `-` prefix (markdown style)
- Each bullet should explain WHY the change was made, not just WHAT changed
- Group related file changes into single bullets when appropriate
- Omit implementation details - focus on high-level impact
- Do not include code blocks, technical jargon, or file paths unless essential
- The output should be immediately usable as a PR description

Start by using Glob to find matching log files in ./.claude/logs/, read them for context, then generate the PR description.
