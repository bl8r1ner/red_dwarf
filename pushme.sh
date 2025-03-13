#!/bin/bash

# Check if a commit message is provided
if [ -z "$1" ]; then
  echo "Error: No commit message provided."
  echo "Usage: ./pushme \"Your commit message\""
  exit 1
fi

# Use the provided commit message
commit_message="$1"
git add .
git commit -m "$commit_message"
git push
