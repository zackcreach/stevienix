## Coding standards

- Always prefer descriptive variable names instead of comments to keep the code readable and maintainable
- Do not abbreviate argument names (e.g. e for error). Always write out error
- Use pattern matching as much as possible throughout variable declarations and functions, avoiding if statements whenever possible and favoring guard (when) clauses

## Testing

When writing unit and end to end tests:

- Do not write comments in test files
- In elixir files, always aggressively look for ways to pattern match on both variables, functions, and when writing assertions
- Always prefer descriptive variable names to tell a story over comments
- Do not consider any task complete unless all tests are passing

## Global dependencies

- When installing new global dependencies or cli tools, always assume they should be installed via nix configuration found in ~/dev/nixos, never homebrew or npm or other package managers
- nixos home manager should be the first place to look when configuring new global dependencies, followed by nixpkgs unstable

## Comments and documentation

- Do not add comments unless absolutely necessary (such as JSDocs, @moduledoc, @doc, etc.). We want to instead let the code be readable enough through the use of descriptive variable names.
- When writing documentation, be concise and brief as much as possible
