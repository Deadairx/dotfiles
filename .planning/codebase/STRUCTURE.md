# Codebase Structure

**Analysis Date:** 2026-03-07

## Directory Layout

```
[project-root]/
├── bin/                  # Stow package: user scripts under ~/.local/bin
├── nvim/                 # Stow package: Neovim config under ~/.config/nvim
├── tmux/                 # Stow package: tmux config under ~/.tmux.conf
├── zsh/                  # Stow package: zsh config under ~/.zshrc + plugin dirs
├── karabiner/            # Stow package: goku/karabiner config under ~/.config
├── espanso/              # Stow package: macOS Espanso config under ~/Library/...
├── wezterm/              # Stow package: WezTerm config under ~/.config/wezterm
├── ghostty/              # Stow package: Ghostty config under ~/.config/ghostty
├── starship/             # Stow package: Starship config under ~/.config
├── utils/                # Helper scripts referenced by other configs
├── iTerm/                # iTerm theme exports (manual import)
├── Rectangle/            # Rectangle config export (manual import)
├── Typinator/            # Typinator abbreviation set export (manual import)
├── Keyboard Meastro/     # Keyboard Maestro macro export (manual import)
├── vim/                  # Legacy vim configs (not stowed by default)
├── old-zsh/              # Legacy zsh manager scripts (not stowed by default)
├── .gitignore            # Repo ignore rules (includes `.credentials`)
├── README.md             # Bootstrap notes; expects repo at ~/dotfiles
├── mac                   # Main bootstrap: sets STOW_FOLDERS and runs install
├── install               # Stow loop: unstow + restow selected packages
├── clean-env             # Unstow loop: remove selected packages
├── brew-app-installs.sh  # Homebrew + app/tool installation helper
├── deploy                # Legacy interactive bootstrap (writes dotfiles directly)
└── .planning/codebase/   # Generated codebase mapping docs
```

## Directory Purposes

**bin/:**
- Purpose: stow-managed CLI scripts.
- Contains: `bin/.local/bin/tmux-sessionizer`.
- Key files: `bin/.local/bin/tmux-sessionizer`

**nvim/:**
- Purpose: Neovim configuration.
- Contains: Lua-based config tree.
- Key files: `nvim/.config/nvim/init.lua`, `nvim/.config/nvim/lazy-lock.json`

**tmux/:**
- Purpose: tmux configuration.
- Contains: main config plus keybindings include.
- Key files: `tmux/.tmux.conf`, `tmux/tmux-keybindings.conf`

**zsh/:**
- Purpose: zsh configuration and plugin sources.
- Contains: `zsh/.zshrc` plus vendored plugin directories.
- Key files: `zsh/.zshrc`, `zsh/plugins/`

**karabiner/:**
- Purpose: keyboard remapping rules for goku -> karabiner.
- Contains: `karabiner/.config/karabiner.edn`.
- Key files: `karabiner/.config/karabiner.edn`

**espanso/:**
- Purpose: macOS Espanso config and snippets.
- Contains: `espanso/Library/Application Support/espanso/...`.
- Key files: `espanso/Library/Application Support/espanso/config/default.yml`, `espanso/Library/Application Support/espanso/match/base.yml`

**wezterm/:**
- Purpose: WezTerm terminal config.
- Contains: `wezterm/.config/wezterm/wezterm.lua`.
- Key files: `wezterm/.config/wezterm/wezterm.lua`

**ghostty/:**
- Purpose: Ghostty terminal config + custom shader.
- Contains: `ghostty/.config/ghostty/config`, `ghostty/.config/ghostty/custom-shaders/`.
- Key files: `ghostty/.config/ghostty/config`, `ghostty/.config/ghostty/custom-shaders/crt-shader.glsl`

**starship/:**
- Purpose: Starship prompt configuration.
- Contains: `starship/.config/starship.toml`.
- Key files: `starship/.config/starship.toml`

**utils/:**
- Purpose: helper utilities referenced by stowed configs.
- Contains: clipboard helper used by tmux copy-mode.
- Key files: `utils/copy`

**iTerm/:**
- Purpose: theme export files.
- Key files: `iTerm/Themes/Gruvbox Dark.itermcolors`, `iTerm/Themes/Gruvbox Light.itermcolors`

**Rectangle/:**
- Purpose: Rectangle app config export.
- Key files: `Rectangle/RectangleConfig.json`

**Keyboard Meastro/:**
- Purpose: Keyboard Maestro macros export.
- Key files: `Keyboard Meastro/App Switching Macros.kmmacros`

## Key File Locations

**Entry Points:**
- `mac`: main “stow these packages” entry point.
- `install`: stow implementation loop.
- `clean-env`: unstow loop.

**Configuration:**
- `mac`: default `STOW_FOLDERS` list.
- `README.md`: minimal bootstrap instructions.
- `.gitignore`: ignores `.credentials` (local-only secret file).

**Core Logic:**
- `install`: `stow -D` then `stow` for each selected package.

**Testing:**
- Not applicable (dotfiles repo).

## Naming Conventions

**Files:**
- Dotfiles at package root map to `$HOME` (e.g. `zsh/.zshrc` -> `~/.zshrc`, `tmux/.tmux.conf` -> `~/.tmux.conf`).
- XDG configs live under `.config/` within a package (e.g. `nvim/.config/nvim/init.lua` -> `~/.config/nvim/init.lua`).
- macOS app configs that live under `~/Library/...` are represented as `Library/...` within the relevant package (e.g. `espanso/Library/Application Support/espanso/...`).

**Directories:**
- Top-level directories intended for stow are treated as packages and listed in `mac` via `STOW_FOLDERS`.

## Where to Add New Code

**New Tool Config (stow-managed):**
- Add a new package directory at repo root (e.g. `alacritty/`).
- Inside it, create destination-shaped paths (e.g. `alacritty/.config/alacritty/alacritty.toml`).
- Add the package name to `STOW_FOLDERS` in `mac` so it stows by default.

**New Script/Executable:**
- Put scripts in `bin/.local/bin/` so they land in `~/.local/bin/` via stow.

**Shared Utilities:**
- Put helper scripts in `utils/` when they are referenced by configs using `~/dotfiles/...` paths (example: `tmux/tmux-keybindings.conf` uses `~/dotfiles/utils/copy`).

## Special Directories

**.planning/codebase/:**
- Purpose: generated mapping docs for GSD workflows.
- Generated: Yes.
- Committed: Yes (intended).

---

*Structure analysis: 2026-03-07*
