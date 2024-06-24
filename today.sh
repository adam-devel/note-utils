#!/usr/bin/env sh

# This script generates today's quick note's name
# quick notes are meant to be unstructured dumps of thoughts as they come.
# quick notes can later be discarded or used to develop better structured notes.

printf '%s' "quicknote$(date +%Y-%m-%d).md"

