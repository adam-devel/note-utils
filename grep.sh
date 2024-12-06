#!/usr/bin/env bash

# This script uses ripgrep, fzf and bat to interactively find, select, and
# preview notes.
# The script returns a string of the format "FILE\tLINE_NUMBER".
# FILE is the path of the selected file (the note)
# LINE_NUMBER is the line number for the matched string

# This script takes takes the notes directory as a first argument
# and an initial search query as a second argument

set -eu

print_usage_help() {
  cat <<EOF
Usage: grep <notes_directory> [search_pattern]
Where: <notes_directory> is the directory where the notes are stored
       and [search_pattern] is the optional initial search pattern
EOF
}

if (($# < 1)); then
  echo insuffictient number of arguments !
  print_usage_help
  exit
fi

notes_directory="$1"
initial_query=${2:-''}

FZF_INPUT_COMMAND=(rg
  --column --line-number --no-heading
  #--color=always
  --type=md
  #--fixed-strings
  --smart-case
  -- '{q}'
  "'$notes_directory'")

FZF_PREVIEW_COMMAND=(
  bat
  --color=always
  --style="numbers"
  --highlight-line '{2}'
  '{1}'
)

fzf \
  --ansi --disabled \
  --info=inline \
  --query "$initial_query" \
  --bind "start:reload:${FZF_INPUT_COMMAND[*]}" \
  --bind "change:reload:${FZF_INPUT_COMMAND[*]}" \
  --delimiter : \
  --preview "${FZF_PREVIEW_COMMAND[*]}" \
  --preview-window 'bottom,80%,border-top,+{2}+3/3,~3' \
  --bind "enter:become(printf '%s\t%d' {1} {2})" \
  --prompt "[rip]grep> "
