#!/bin/bash
  input=$(cat)
  model=$(echo "$input" | jq -r '.model.display_name')
  cwd=$(echo "$input" | jq -r '.workspace.current_dir')
  output_style=$(echo "$input" | jq -r '.output_style.name')

  # Get git info
  cd "$cwd" 2>/dev/null
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
      if [ -z "$(git status --porcelain 2>/dev/null)" ]; then
          git_status=""
      else
          git_status="*"
      fi
      git_info="on $(printf '\033[35m')󰊢 ${branch}${git_status}$(printf '\033[0m')"
  fi

  # Build status line
  status="$(printf '\033[34m')${model}$(printf '\033[0m')"
  status="${status} ${git_info}"

  if [ "$output_style" != "default" ] && [ "$output_style" != "null" ]; then
      status="${status} [${output_style}]"
  fi

  echo "$status"
