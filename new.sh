#!/bin/bash

# this interactive script opens a new note with a temporary initial name, then
# prompts for the final name when the user saves and quit
# It takes two positional arguments:
# 1. the editor command
# 2. the notes directory

set -eu

# fail if no arguments are given
if (($# != 2)); then
  exit 1
fi
NOTES_DIRECTORY=$2
EDITOR=$1

# choose a random name for the note
editing_file="$NOTES_DIRECTORY/newnote${RANDOM}"

# use the file
$EDITOR "$editing_file" &&
  # choose a new note name
  while true; do
    read -r -p "Note name: " final_name &&
      final_path="$NOTES_DIRECTORY/$final_name.md"
    if [ -a "$final_path" ]; then
      continue
    else
      mkdir -p "$(dirname "$final_path")"
      mv "$editing_file" "$final_path"
      break
    fi
  done
