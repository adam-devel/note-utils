#!/usr/bin/env bash

# this script selects a random note
# this secript takes an argument for the notes directory

# fail if no arguments are given
if (($# != 1)); then
  exit 1
fi
NOTES_DIRECTORY=$1

# the inefficiency of the current implementation
# bothers me a little
FIND_COMMAND_ZERO_TERMINATED=(fd
  --search-path "$NOTES_DIRECTORY"
  --type file
  --glob '*.md'
  --print0)

declare -a search_results
readarray -d '' search_results < <("${FIND_COMMAND_ZERO_TERMINATED[@]}")

# is this really how one is supposed to index a random element in bash
printf "%s" "${search_results[$((RANDOM % "${#search_results[@]}"))]}"
