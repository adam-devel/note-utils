#!/usr/bin/env bash

# This script uses fd and fzf to interactively find a note
# This script requires two arguments, the first being the directory under which
# notes are located, and the second is an optional initial search query

# expect at least 1 argument (the second is optional)
if (($# < 1)); then
  exit
fi

NOTES_DIRECTORY=$1

FZF_PREVIEW_COMMAND=(
  bat
  --color=always
  --style="numbers"
  '{}'
)

FIND_COMMAND=(
  fd
  --search-path "$NOTES_DIRECTORY"
  --type file
  --and '.md$'
  --print0 # outputs a NUL separated list
)

FZF_COMMAND=(
  fzf
  --prompt 'Open note> '
  --delimiter / --with-nth -1
  --preview "${FZF_PREVIEW_COMMAND[*]}"
  --read0 # read a NUL separated list
)

# if a 2nd argument is receieved, pass it as a query to fzf
if (($# == 2)); then
  FZF_COMMAND+=(--query "$2")
fi

chosen_note="$("${FIND_COMMAND[@]}" | "${FZF_COMMAND[@]}")"
if [[ -f "$chosen_note" ]]; then
  printf '%s' "$chosen_note"
else
  exit 1
fi
