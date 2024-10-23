# Practical Git Commands

These are some practical Git commands for quick commits and pushes in different environments.

### CloudSpaces Copilot Commit

```bash
git pull; git add . && git commit -m "cloudspaces copilot commit" && git push; clear
```

### Cursor Commit Windows
```bash
git pull; git add . && git commit -m "cursor commit windows" && git push; clear
```

### Cursor Commit Mac
```bash
git pull; git add . && git commit -m "cursor commit mac" && git push; clear
```

### Update VSCode Integrated Terminal Name

```bash
# Set VSCode integrated terminal title to "New Terminal Name"
echo -ne "\033]0;New Terminal Name\007"
```

## Explanation

- The Git commands perform a quick pull, add, commit, and push sequence.
- The terminal name update command uses ANSI escape codes to change the title.
- For VSCode's integrated terminal, this command should work on most systems.

## Note
- Replace "New Terminal Name" with your desired terminal name.
- The terminal name change is temporary and will reset when you close the terminal.
- Some systems or terminal emulators might not support this feature.
