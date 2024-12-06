#!/bin/bash

# this script opens a new note and assumes the first line to be the file name
# It takes two arguments: 1. the editor command and 2. the notes directory

set -eu

# fail if no arguments are given
if (($# != 2)); then
  exit 1
fi

NOTES_DIRECTORY=$2
EDITOR=$1

# choose a random name for the note
editing_file="$NOTES_DIRECTORY/newnote${RANDOM}.md"

# choose a new note name
while true; do
  $EDITOR "$editing_file"
  final_name="$(head --lines=1 -- "$editing_file")"
  final_path="$NOTES_DIRECTORY/$final_name.md"
  [[ -e "$final_path" ]] && continue
  mkdir -p "$(dirname "$final_path")"
  mv "$editing_file" "$final_path" || continue;
  break
done
