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
[1-2 sentence high-level overview - keep it general, no specific details]

- [Brief change: module/file name + general purpose in a few words]
- [Brief change: module/file name + general purpose in a few words]
- [Additional bullets as needed, keep each very short]
```

GUIDELINES:

- Keep everything extremely high-level and general
- The overview should be broad and conversational - avoid specifics
- Wrap module, file, or function names in backticks for markdown formatting
- Bullet points can mention module/file names but should NOT explain details
- Each bullet should be a short phrase, not a full sentence
- Group related changes aggressively - fewer bullets is better
- Omit implementation details, configuration values, and technical specifics
- Think "what area changed" not "what specifically changed"
- The reader should get the gist without understanding the codebase

Start by using Glob to find matching log files in ./.claude/logs/, read them for context, then generate the PR description.
