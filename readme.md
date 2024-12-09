A set of simple bash scripts for finding, opening, creating and managing notes. The scripts are simple, they don't assume much. They are meant to be easily integrated into one's preferred environment.

The following —and the source code— are the documentation:
- `resolve` Takes two arguments: 1) a search query and 2) the directory containing the notes; `resolve` outputs the location of a note matching the query.
- `edit`: Takes two arguments: 1) an editor command and 2) the file path for a note. It inserts the file name at the top of the note before opening it. If the line changes, it renames the file accordingly. This allows the note's name to serve as the title. this streamlines editing
- `select_with_*` are scripts starting with `select_with_`. They allow selecting a note in various ways, using different menu programs, runners, launchers, etc.. The output is a file path to the selected note
- `select_random` outputs a random note given a notes directory

# Usage Examples

You can bind these to your preferred window manager

```sh
# select a note with bemenu and open it with neovide
# or use your preferred editor and menu program
select_with_bemenu ~/notes | xargs -d'\n' note_edit neovide

# open a new note with the name stored at clipboard
# (use `xclip -sel clip` intead of `wl-paste` if you are on X11)
edit neovide ~/notes/"$(wl-paste)"

# if your editor doesn't support jumping to the file at the cursor
# you can copy the filename then hit a keybind to call this command
# which would open the note that matches the name you copied
resolve "$(wl-paste)" ~/notes | xargs -d"\n" note_edit neovide
```

Note: Piping the result to `xargs` may seem like a roundabout way to pass command results as arguments. it's because a failing command halts the pipeline, preventing invalid output from being passed to subsequent commands. whilst command substitution will pass the result regardless of success

# QA

- Q: Why are the names so long and ugly
- A: They are meant to be bound to keys rather than typed
