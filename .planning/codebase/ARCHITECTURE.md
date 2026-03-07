# Architecture

**Analysis Date:** 2026-03-07

## Pattern Overview

**Overall:** GNU Stow package directories that mirror `$HOME` paths

**Key Characteristics:**
- Each top-level “package” directory is a stow target (e.g. `nvim/`, `zsh/`, `tmux/`) containing paths that match where they should land under `$HOME`.
- A thin bootstrap script sets `STOW_FOLDERS` and runs the stow loop; configs assume this repo is checked out at `~/dotfiles`.
- macOS-focused app configs are kept either as stowable trees (e.g. `espanso/Library/...`) or as export/import assets (e.g. `iTerm/Themes/`, `Keyboard Meastro/`).

## Layers

**Bootstrap / Install Scripts:**
- Purpose: Choose stow packages and apply (unstow + restow).
- Location: `mac`, `install`, `clean-env`
- Contains: shell scripts that drive `stow`.
- Depends on: `stow` being installed; env vars `DOTFILES` and `STOW_FOLDERS`.
- Used by: manual invocation (e.g. run `./mac`).

**Stow Packages (Symlink Sources):**
- Purpose: Provide dotfiles/config trees that stow into `$HOME`.
- Location: `bin/`, `nvim/`, `tmux/`, `zsh/`, `karabiner/`, `espanso/`, `wezterm/`, `ghostty/`, `starship/`
- Contains: dotfiles and config directories (notably `.config/` and macOS `Library/`).
- Depends on: conventions of each tool (Neovim, tmux, zsh, etc.).
- Used by: `install` via `stow $folder`.

**Non-stowed Assets / Exports:**
- Purpose: Keep importable settings/theme files that are not currently managed via stow.
- Location: `iTerm/`, `Rectangle/`, `Typinator/`, `Keyboard Meastro/`, `vim/`, `old-zsh/`
- Contains: theme exports, app config exports, legacy configs.
- Depends on: manual import into apps and/or legacy bootstrap scripts.

## Data Flow

**Mac Install Flow (`./mac`):**

1. `mac` defines default `STOW_FOLDERS` and `DOTFILES` (defaults `DOTFILES=~/dotfiles`).
2. `mac` executes `install` with those env vars.
3. `install` iterates comma-separated `STOW_FOLDERS` and runs `stow -D $folder` then `stow $folder` from `$DOTFILES`.
4. Result: symlinks created under `$HOME` that point back into the repo.

**Uninstall / Clean Flow:**
- `clean-env` iterates `STOW_FOLDERS` and runs `stow -D $folder` to remove symlinks.

**Repo Location Assumption:**
- Several configs reference absolute `~/dotfiles/...` paths (e.g. `tmux/.tmux.conf` sources `~/dotfiles/tmux/tmux-keybindings.conf`).
- README explicitly expects the repo to be cloned into `$HOME` as `~/dotfiles`: `README.md`.

**State Management:**
- No internal state is tracked; stow’s link state lives in the filesystem.
- Neovim plugin state is managed by Neovim tooling (e.g. `nvim/.config/nvim/lazy-lock.json` for lazy.nvim locking).

## Key Abstractions

**Stow Package:**
- Purpose: A folder at repo root intended to be passed to `stow`.
- Examples: `nvim/`, `zsh/`, `tmux/`, `wezterm/`, `ghostty/`
- Pattern: Package contains “destination-shaped” trees like `.config/nvim/...` or `.zshrc`.

**Bootstrap Environment Variables:**
- Purpose: Configure which packages stow, and where the repo lives.
- Examples: `STOW_FOLDERS` and `DOTFILES` in `mac`, `install`, `clean-env`.

## Entry Points

**mac:**
- Location: `mac`
- Triggers: manual run (`./mac`).
- Responsibilities: default `STOW_FOLDERS`; set `DOTFILES`; invoke `install`.

**install:**
- Location: `install`
- Triggers: called by `mac` (or run directly with env vars).
- Responsibilities: `stow -D` then `stow` for each package.

**clean-env:**
- Location: `clean-env`
- Triggers: manual run with same env vars as `install`.
- Responsibilities: remove stowed symlinks for selected packages.

**brew-app-installs.sh:**
- Location: `brew-app-installs.sh`
- Triggers: manual run during machine bootstrap.
- Responsibilities: install Homebrew and common apps/tools.

## Error Handling

**Strategy:** shell scripts rely on command exit codes and user observation.

**Patterns:**
- `install` and `clean-env` do not validate that `stow` exists or that `STOW_FOLDERS` is set to valid package directories.
- Some scripts in the repo are interactive/legacy (e.g. `deploy`) and not used by the main `mac` flow.

## Cross-Cutting Concerns

**Logging:** simple `echo` output in `install`, `clean-env`, and `brew-app-installs.sh`.
**Validation:** implicit; stow/package existence is not checked in `install`.
**Authentication:** local secrets are expected outside the repo (e.g. `.credentials` ignored by `.gitignore`, sourced from `zsh/.zshrc` via `source ~/.credentials`).

---

*Architecture analysis: 2026-03-07*
