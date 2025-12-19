## Planning

- In planning mode, automatically generate a markdown file named the same name as the current branch (unless already on main branch, then just pick a descriptive title) as soon as a plan proposal has completed. Maintain it as you make changes
- Markdown log files should have detailed checklists to keep track of changes
- Save all log files to ./.claude/logs with the same name as the branch name
- When working off of log files, be sure to update the markdown checklist with what has been completed along with any notes on deviations to the log

## Coding standards

- Always prefer descriptive variable names instead of comments to keep the code readable and maintainable
- Do not abbreviate argument names (e.g. e for error). Always write out error
- Use pattern matching as much as possible throughout variable declarations and functions, avoiding if statements whenever possible and favoring guard (when) clauses
- In elixir projects, always prefer atoms to strings especially for keys when possible, but only if it doesn't add complexity with needing to convert back and forth

## Command line tool calls

- Assume any sudo * commands will need my input. Plan to pause and request that I run sudo commands in order to provide passwords.

## Testing

When writing unit and end to end tests:

- Do not write comments in test files
- In elixir files, always aggressively look for ways to pattern match on both variables, functions, and when writing assertions
- Always prefer descriptive variable names to tell a story over comments
- Do not consider any task complete unless all tests are passing
- ALL tests should call assert as much as possible. Do not consider a test complete until we have asserted on the primary goal of the test

## Global dependencies

- When installing new global dependencies or cli tools, always assume they should be installed via nix configuration found in ~/dev/nixos, never homebrew or npm or other package managers
- nixos home manager should be the first place to look when configuring new global dependencies, followed by nixpkgs unstable

## Comments and documentation

- Do not add comments unless absolutely necessary (such as JSDocs, @moduledoc, @doc, etc.). We want to instead let the code be readable enough through the use of descriptive variable names.
- When writing documentation, be concise and brief as much as possible

## Elixir Code Standards

### Compatibility (Elixir 1.19)

- Requires Erlang/OTP 26-28
- Use `~c"..."` sigil instead of charlist syntax `'...'`
- Move CLI config from `mix.exs` to `def cli` block
- Use `+` separator in `mix do` tasks, not commas
- Use `:default_handler` for Logger config, not `:backends`
- Use `:on_conflict` option for `File.cp/cp_r`, not callbacks

### Naming Conventions

- Modules: `CamelCase`, preserve acronyms (`ExUnit.CaptureIO`, `Mix.SCM`)
- Functions/variables/atoms: `snake_case`
- Trailing `!` raises on failure, `?` returns boolean
- `is_` prefix for type checks valid in guards
- `size` = O(1) operation, `length` = O(n) operation
- `get` returns nil, `fetch` returns `{:ok, val}/:error`, `fetch!` raises

### Patterns and Guards

- Pin operator `^` prevents variable rebinding
- Use `_` for ignored values, never matches
- Map patterns are subset matches (`%{}` matches all maps)
- In guards use `and/or/not`, not `&&/||/!`
- Type checks first in guards to avoid silent failures
- Define custom guards with `defguard/defguardp`
- Integers don't pattern match floats (`1 != 1.0`)

### Operators

- Avoid custom operators (community discourages for readability)
- `===` strict comparison (integers don't match floats)
- `|>` pipeline for left-to-right transformation chains as much as possible

### Typespecs

- `@spec` for function signatures, `@type/@typep/@opaque` for types
- Use `String.t()` or `binary()` for UTF-8 strings, not `string()`
- `no_return()` only for functions that never return
- Union types with `|` operator

### Set-Theoretic Types (v1.19+)

- Sound type inference without annotations
- `dynamic()` type for gradual typing of existing code
- Types compose via unions (`or`), intersections (`and`), negation (`not`)

### Anti-Patterns to Avoid

**Code Anti-Patterns:**
- Comments overuse: prefer clear names over explanatory comments
- Complex `else` in `with`: normalize return types in private functions
- Dynamic atom creation: use `String.to_existing_atom/1` or explicit mapping
- Long parameter lists: group with maps, structs, or keyword lists
- Namespace trespassing: stay within your library's namespace
- Non-assertive map access: use `map.key` for required, `map[:key]` for optional
- Non-assertive pattern matching: fail fast on unexpected input
- Non-assertive truthiness: use `and/or/not` for booleans, not `&&/||/!`
- Structs with 32+ fields: nest or group fields to avoid memory bloat

**Process Anti-Patterns:**
- Code organization by process: use modules/functions, not processes for structure
- Scattered process interfaces: centralize GenServer/Agent interaction in one module
- Sending unnecessary data: extract only needed fields before spawning
- Unsupervised processes: always start processes within supervision trees

**Design Anti-Patterns:**
- Alternative return types: create separate functions instead of options that change return type
- Boolean obsession: use atoms for mutually exclusive states instead of multiple booleans
- Exceptions for control flow: avoid `try/rescue` for expected errors, use `{:ok, result}/{:error, reason}` tuples and `case` instead
- Primitive obsession: create structs/maps for domain concepts
- Unrelated multi-clause functions: split into separate named functions
- App config for libraries: accept config as function parameters, not global env

## React/TypeScript Code Standards

Based on official React documentation (react.dev/reference/rules) and typescript-eslint best practices.

### Component & Hook Purity

- Components must be idempotent: same inputs (props, state, context) → same output
- No side effects during render - use `useEffect` for DOM mutations, timers, subscriptions
- Props and state are immutable - never mutate directly, use setter functions
- Values passed to hooks become immutable
- Local mutation is allowed (arrays/objects created within the render)

### Rules of Hooks

- Only call hooks at top level - not in loops, conditions, nested functions, or try/catch
- Only call hooks from React function components or custom hooks
- Use `eslint-plugin-react-hooks` to enforce these rules

### Component Patterns

- Never call component functions directly (`Article()`) - use JSX (`<Article />`)
- Never pass hooks as props or regular values
- Never create higher-order hooks dynamically
- Use `key` prop with stable unique identifiers for lists (database IDs, not array indices)
- Event handlers: pass reference, don't call (`onClick={handleClick}` not `onClick={handleClick()}`)
- Lift state up to closest common parent that needs it
- Use `className` not `class` in JSX

### TypeScript Naming

- Interfaces/Types: `PascalCase`
- Generic parameters: `TPascalCase` (e.g., `TRequest`, `TResponse`) - avoid single letters like `T`, `K`
- Variables/functions: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE` or `camelCase`

### TypeScript Type Safety

- Prefer `unknown` over `any` - forces type checking before use
- Use `as const` for literal types and readonly arrays/objects
- Prefer `interface` for object shapes, `type` for unions/intersections/mapped types
- Use `readonly` for immutable data structures
- Avoid type assertions (`as`) - prefer type guards and narrowing
- Use `satisfies` for type checking without widening

### TypeScript Patterns

- Use discriminated unions for state machines and tagged unions
- Prefer `Map`/`Set` over object index signatures for dynamic keys
- Avoid enums - use const objects with `as const` or union types instead
- Use `never` for exhaustive switch/if checks
- Prefer nullish coalescing (`??`) over logical or (`||`) for defaults
