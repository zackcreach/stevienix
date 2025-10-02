## Testing

When writing unit and end to end tests:

- Always prefer descriptive variable names to tell a story over comments
- Avoid adding comments in test files
- When specifically working with elixir tests, opt for asserting on deep pattern matching versus individual assertions
- Do not consider the task complete unless all tests are passing

## Global dependencies

- When installing new global dependencies or cli tools, always assume they should be installed via nix configuration found in ~/dev/nixos, never homebrew or npm or other package managers
- nixos home manager should be the first place to look when configuring new global dependencies, followed by nixpkgs unstable
