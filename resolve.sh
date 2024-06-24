#!/usr/bin/env bash

# This script resolves a link from one note to another.
# Finding the target of a link is no more than finding the match of an exact
# search by file name. If no matches are found, the script fails

# The user must supply an argument
if (($# < 1)); then
  exit
fi

SEARCH_QUERY="$1"
FIND_COMMAND=(fd
  --type file
  --search-path "$HOME/mind/"
  --glob "$SEARCH_QUERY.md"
  --print0
)

declare -a search_results
readarray -d '' search_results < <("${FIND_COMMAND[@]}")

if ((${#search_results[@]} == 1)); then
  $EDITOR "${search_results[0]}"
else
  exit 1
fi
