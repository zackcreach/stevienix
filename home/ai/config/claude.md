## Testing

When writing unit and end to end tests:

- Always prefer descriptive variable names to tell a story over comments
- Avoid adding comments in test files

## Global dependencies

- When installing new global dependencies or cli tools, always assume they should be installed via nix configuration found in ~/dev/nixos, never homebrew or npm or other package managers
- nixos home manager should be the first place to look when configuring new global dependencies, followed by nixpkgs unstable

## Memory

- For new local memory changes, save them inside ./creachignore/ instead of the default ./.claude directory. This includes changes to CLAUDE.md but also any commands or other files you would otherwise generate inside ./.claude
