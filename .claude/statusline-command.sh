#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# ANSI color codes
CYAN='\033[36m'
YELLOW='\033[33m'
GREEN='\033[32m'
RED='\033[31m'
BLUE='\033[34m'
MAGENTA='\033[35m'
RESET='\033[0m'

# Extract directory name
dir=$(echo "$input" | jq -r '.workspace.current_dir')
dir_name=$(basename "$dir")

# Extract model name
model_name=$(echo "$input" | jq -r '.model.display_name')

# Get git branch (skip optional locks)
git_branch=""
if [ -d "$dir/.git" ]; then
  git_branch=$(cd "$dir" && git -c core.useReplaceRefs=false rev-parse --abbrev-ref HEAD 2>/dev/null)
fi

# Get git status (skip optional locks)
git_status=""
git_status_color=""
if [ -n "$git_branch" ]; then
  # Check if working tree is clean
  if [ -z "$(cd "$dir" && git -c core.useReplaceRefs=false status --porcelain 2>/dev/null)" ]; then
    git_status="✓"
    git_status_color="$GREEN"
  else
    git_status="±"
    git_status_color="$RED"
  fi
fi

# Calculate context window percentage
usage=$(echo "$input" | jq '.context_window.current_usage')
context_pct=""
if [ "$usage" != "null" ]; then
  current=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
  size=$(echo "$input" | jq '.context_window.context_window_size')
  if [ "$current" != "null" ] && [ "$size" != "null" ] && [ "$size" -gt 0 ]; then
    pct=$((current * 100 / size))
    context_pct="${pct}%"
  fi
fi

# Build colorized status line
printf "${CYAN}%s${RESET}" "$dir_name"

if [ -n "$git_branch" ]; then
  printf "  ${YELLOW}%s${RESET} ${git_status_color}%s${RESET}" "$git_branch" "$git_status"
fi

if [ -n "$model_name" ]; then
  printf "  ${BLUE}%s${RESET}" "$model_name"
fi

if [ -n "$context_pct" ]; then
  printf "  ${MAGENTA}%s${RESET}" "$context_pct"
fi
