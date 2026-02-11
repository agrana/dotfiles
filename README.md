# dotfiles

Personal macOS dotfiles focused on reproducible developer setup with Homebrew, Neovim, and VS Code.

## What this repo contains

- `Brewfile`: Homebrew taps, formulae, casks, VS Code extensions, Go tools, and cargo crates.
- `backup-brew.sh`: Regenerates `Brewfile` from the current machine state.
- `.config/nvim/init.lua`: Neovim configuration using built-in `vim.pack`.
- `.config/nvim/nvim-pack-lock.json`: lockfile for Neovim plugin versions.
- `vs-code-settings.json`: VS Code user settings snapshot.
- `vs-code-extensions.txt`: VS Code extension list.
- `identify_big_blobs_git_history.sh`: Helper to find the largest blobs in git history.
- `tmp-man/`: local man page files related to `himalaya`.

## Prerequisites

- macOS
- [Homebrew](https://brew.sh/)
- Optional: VS Code with `code` CLI enabled

## Bootstrap a new machine

1. Clone this repository.
2. Install Homebrew packages:

```bash
brew bundle --file Brewfile
```

3. Link Neovim config:

```bash
mkdir -p ~/.config
ln -sfn "$(pwd)/.config/nvim" ~/.config/nvim
```

4. Apply VS Code settings and extensions:

```bash
cp "$HOME/Library/Application Support/Code/User/settings.json" \
  "$HOME/Library/Application Support/Code/User/settings.json.bak" 2>/dev/null || true
cp vs-code-settings.json "$HOME/Library/Application Support/Code/User/settings.json"
xargs -L 1 code --install-extension < vs-code-extensions.txt
```

## Maintenance

Refresh `Brewfile` after changing installed tools:

```bash
./backup-brew.sh
```

Write to a custom path:

```bash
./backup-brew.sh --file ./Brewfile
```

Inspect large git objects:

```bash
bash identify_big_blobs_git_history.sh
```
