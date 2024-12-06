#!/usr/bin/env bash

# This script uses fd, fzf and bat to find, select and preview notes
# This script requires two arguments, the first being the directory under which
# notes are located, and the second is an optional initial search query

# expect at least 1 argument
if (($# < 1)); then
  echo "refusig to run without arguments"
  echo "usage: $0 <notes_directory> [search_query]"
  echo "examples:"
  echo "$0 /path/to/notes"
  echo "$0 /path/to/notes metaphysics"
  exit 1
fi

NOTES_DIRECTORY=$1

FZF_PREVIEW_COMMAND=(
  command bat
  --color=always
  --style="numbers"
  '{}' # place holder for the currently selected file in fzf
)

FIND_COMMAND=(
  command fd
  --search-path "$NOTES_DIRECTORY"
  --type file
  --and '.md$'
  --print0 # NUL separated output
)

FZF_COMMAND=(
  command fzf
  --prompt 'Open note> '
  --delimiter / --with-nth -1
  --preview "${FZF_PREVIEW_COMMAND[*]}"
  --read0 # read a NUL separated input
)

# if a 2nd argument is receieved, pass it as a query to fzf
if (($# == 2)); then
  FZF_COMMAND+=(--query "$2")
fi

chosen_note="$("${FIND_COMMAND[@]}" | "${FZF_COMMAND[@]}")"
if [[ -f "$chosen_note" ]]; then
  printf '%s' "$chosen_note"
else
  exit 2
fi
