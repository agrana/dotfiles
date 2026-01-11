# Repository Guidelines

## Project Structure & Module Organization
- `init.lua` contains the entire Neovim configuration, including options, plugin setup, and keymaps.
- `nvim-pack-lock.json` is the lockfile for `vim.pack` plugin versions; treat it as generated state.
- There are no separate source/test directories; keep config additions grouped by purpose inside `init.lua`.

## Build, Test, and Development Commands
- `nvim`: launch Neovim with this config to validate changes interactively.
- `:checkhealth`: run Neovim’s built-in health checks after plugin or option changes.
- `:packadd {plugin}` (when needed): manually load a plugin to verify it installs and initializes.

## Coding Style & Naming Conventions
- Language: Lua (Neovim config).
- Indentation: follow the existing style in `init.lua` (tabs are currently used in the plugin list).
- Keep sections labeled with short comment blocks and group related settings together (options, plugins, keymaps, theme).
- Prefer descriptive keymap `desc` values and consistent leader mappings (leader is set to space).

## Testing Guidelines
- No automated tests are present.
- Validate changes by launching Neovim, ensuring startup has no errors, and confirming plugin features work (e.g., `:Outline`, `<leader>p`).
- If you change plugins, ensure `nvim-pack-lock.json` updates as expected.

## Commit & Pull Request Guidelines
- This directory is not a Git repository, so no commit history or conventions are available.
- If you add version control later, use clear, imperative commit messages (e.g., “Add outline.nvim config”) and include a short PR description of behavior changes.

## Configuration & Security Tips
- Plugin sources are fetched from GitHub; review URLs before adding new plugins.
- Avoid storing secrets in `init.lua`; prefer environment variables or local machine-specific files not committed here.
