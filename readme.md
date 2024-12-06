A set of simple bash scripts for finding, opening, creating and managing notes. the scripts are simple, they don't assume much. they are meant to easily be integrated into one's preferred envirenment.

The following —and the source code— are the documentation:
- `resolve` takes two arguments, 1. a search query and 2. the location of the notes. it outputs the first note it finds that matches query.
- `edit` takes two arguments, 1. a editor command and 2. a path to a file. it inserts the file name at the top of the file before opening it. afterwards it changes the name of the file if the first line changes. this allow the name of the note (playing the role of it's title) to be as easily cnageable as the rest of the text of the note
- `select_with_*` are scripts that start with `select_with_`. they allow selecting a note using different menu programs, runners, launchers, etc.. they output a path to the selected note
- `select_random` outputs a random note given a notes directory

# Usage Examples

You can bind these to your preferred window manager

```sh
# select a note with bemenu and open it with neovide
# use your preferred editor and and menu program
note_select_with_bemenu ~/notes | xargs -d'\n' note_edit neovide

# open a new note with the name stored at clipboard
# (use `xclip -sel clip` intead of `wl-paste` if you are on X11)
note_edit neovide ~/notes/"$(wl-paste)"

# if your editor doesn't support jumping to the file at the cursor
# you can copy the filename then hit a keybind to call this command
# which would open the note that matches the name you copied
note_resolve "$(wl-paste)" ~/notes | xargs -d"\n" note_edit neovide
```

Note: Piping the result to `xargs` seems like a raoundabout way to pass command
results as an argument. the reason for the choice is that a failing command
fails the while pipeline preventing passing invalid output to the commands
consuming it. whilst a command substitution passes the result regardless.

# QA

- Q: Why are the names so long and ugly
- A: They are meant to be bound to keys rather than typed
