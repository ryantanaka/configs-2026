nal Setup

My terminal environment: tmux + fzf + ripgrep on macOS with iTerm2.

## Prerequisites

- **iTerm2** — [download](https://iterm2.com). macOS Terminal.app works but has weaker true color and mouse passthrough support.
- **Homebrew** — [install](https://brew.sh) if you don't have it.

### iTerm2 configuration

**Option key fix** — needed for `Alt` keybindings in tmux (pane switching, window cycling):

1. iTerm2 → Settings → Profiles → Keys → General
2. Set **Left Option Key** to **Esc+**

`Alt+Arrow` pane switching works out of the box in iTerm2. If you try this in Terminal.app instead, `Alt+Left/Right` may not work because Terminal.app handles Option key events differently.

**Version your iTerm2 config** (optional):

1. iTerm2 → Settings → General → Settings
2. Enable **Load preferences from a custom folder or URL**
3. Enable **Save changes to folder when iTerm2 quits**
4. Point both to a folder in your dotfiles (e.g. `~/.dotfiles/iterm2/`)

Or from the command line:

```bash
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
```

## Install

```bash
# Install tools
brew install tmux fzf ripgrep

# Set up fzf shell keybindings (say yes to all prompts)
$(brew --prefix)/opt/fzf/install
```

## tmux

Copy `tmux.conf` to your home directory:

```bash
cp tmux.conf ~/.tmux.conf
```

If tmux is already running, reload the config:

```bash
tmux source-file ~/.tmux.conf
```

### What the config does

- **Prefix** remapped to `Ctrl+a` (default is `Ctrl+b`)
- **Splits** use `|` and `-` instead of `%` and `"`, and open in the current directory
- **Pane navigation** with `Alt+Arrow` keys (no prefix needed)
- **Pane resizing** with `Shift+Arrow` keys (no prefix needed)
- **Window cycling** with `Shift+Alt+Left/Right` (no prefix needed)
- **Fuzzy session/window switching** with `prefix + S` and `prefix + W` via fzf
- **Vi-style copy mode** with `v` to select and `y` to copy to macOS clipboard
- **Mouse support** enabled (click panes, drag borders, scroll)
- **True color** configured for proper vim/neovim colors
- **Status bar** styled with Catppuccin Mocha colors (swap the hex values if you use a different theme)

### Matching the status bar to Gruvbox

If you use Gruvbox in vim/neovim, replace the status bar section with:

```bash
set -g status-style "bg=#282828,fg=#928374"
set -g window-status-current-style "bg=#504945,fg=#ebdbb2,bold"
set -g status-left "#[fg=#ebdbb2,bold] #S #[fg=#504945]│ "
set -g status-right "#[fg=#928374] %b %d  %H:%M "
set -g pane-border-style "fg=#3c3836"
set -g pane-active-border-style "fg=#b8bb26"
```

### Color chain

Terminal colors flow through three layers: iTerm2 → tmux → vim. The config handles this with:

```bash
set -g default-terminal "screen-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
```

To verify true color is working inside tmux:

```bash
printf "\x1b[38;2;255;100;0mTRUE COLOR TEST\x1b[0m\n"
```

If the text appears bright orange, true color is passing through correctly.

## fzf

After running the install script, fzf adds three keybindings to your shell:

- `Ctrl+R` — fuzzy search command history
- `Ctrl+T` — fuzzy find a file and insert its path at the cursor
- `Alt+C` — fuzzy find a directory and cd into it

### Make fzf use ripgrep for file listing

Add to `~/.zshrc`:

```bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
```

This makes `Ctrl+T` and fzf's file listing respect `.gitignore` and skip `node_modules`, build artifacts, etc.

### Verify fzf shell integration is loaded

One of these lines should be in your `~/.zshrc`:

```bash
source <(fzf --zsh)
# or
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
```

If neither is present, add `source <(fzf --zsh)` to the end of `~/.zshrc`.

## ripgrep

ripgrep (`rg`) searches file contents. It respects `.gitignore`, skips binaries, and is fast.

```bash
rg "searchTerm"              # search current directory recursively
rg "searchTerm" -t java      # limit to Java files
rg "searchTerm" -C 3         # show 3 lines of context
rg -i "searchterm"           # case insensitive
rg -l "TODO"                 # list filenames only
```

### Interactive code search (fzf + ripgrep)

Add to `~/.zshrc`:

```bash
rfv() {
  rg --column --line-number --no-heading --color=always --smart-case "${*:-}" |
    fzf --ansi \
        --delimiter : \
        --bind 'enter:become(nvim {1} +{2})'
}
```

Run `rfv` in any project to interactively search code and open matches in neovim.

## Cheat sheet

A quick-reference script for all tmux keybindings in this config.

```bash
mkdir -p ~/.local/bin
cp tmux-cheat ~/.local/bin/tmux-cheat
chmod +x ~/.local/bin/tmux-cheat
```

Make sure `~/.local/bin` is in your PATH. Add to `~/.zshrc` if needed:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Then run `tmux-cheat` from anywhere to see the reference.

## Files

```
tmux.conf     → ~/.tmux.conf
tmux-cheat    → ~/.local/bin/tmux-cheat
```
