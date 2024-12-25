A set of simple bash scripts for note taking. The scripts are simple, they don't assume much. They are meant to be easily integrated into one's preferred environment.

The following —and the source code— are the documentation:
- `resolve` Takes three positional arguments: 1) an optional flag (`-p` or `--pass`), 2) a search query and 3) the directory containing the notes; `resolve` outputs the absolute path of the note matching the query. if the `--pass` flag is present and no notes are found, the search query is appended to the notes' location then passed to stdout. the purpose of this is being able to resolve nonexitent files.
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

# Format

Notes are assumed to be plain text files. the scripts do not parse the text in any way. at least not yet.