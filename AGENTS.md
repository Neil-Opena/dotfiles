# AGENTS.md

Agent-agnostic instructions for AI coding assistants working with this repository.

## Repository Overview

Dotfiles repository managing macOS development environment configs. When modifying files:
- **Neovim** - Two configs: `nvim` (LazyVim full) and `nvim_simple` (minimal). Plugin configs in `lua/plugins/`
- **Tmux** - Multiplexer config at `home/.config/tmux/tmux.conf`. Prefix `Ctrl+Space`
- **Ghostty** - Terminal config at `home/.config/ghostty/config`
- **Herdr** - Agent multiplexer at `home/.config/herdr/config.toml`
- **Shell** - Zsh config at `home/.zshrc`, Starship prompt at `home/.config/starship.toml`

User setup instructions in README.md. Agent-specific guidance below.

## Theme Consistency

Entire setup uses **VSCode Dark+ theme** for visual consistency:
- Neovim (nvim): `vscode.nvim` colorscheme
- Neovim (nvim_simple): Rose Pine Moon theme
- Tmux: Custom VSCode Dark+ colors for pane borders (#5A5A5A inactive, #569CD6 active)
- Ghostty: VSCode Dark+ palette defined in config
- Starship: Custom `vscode_dark_plus` palette defined in starship.toml

When modifying theme/colors in any tool, maintain VSCode Dark+ color values to preserve consistency (nvim_simple uses Rose Pine independently).

## File Structure

```
.
├── home/                    # Mirrors ~ home directory structure
│   ├── .bashrc             # Bash shell config
│   ├── .zshrc              # Zsh shell config (loads nvm, bun, starship)
│   ├── AGENTS.md           # Global agent instructions (agent-agnostic)
│   ├── .claude/            # Claude Code settings and hooks (individual files symlinked to ~/.claude/)
│   │   ├── hooks/          # Event hooks (caveman mode, prompt submit)
│   │   ├── settings.json   # Claude Code settings
│   │   ├── settings.local.json # Local overrides
│   │   └── statusline-command.sh # Custom statusline script
│   └── .config/            # Mirrors ~/.config structure
│       ├── nvim/           # Neovim LazyVim configuration (full-featured)
│       │   ├── init.lua    # Entry point
│       │   └── lua/
│       │       ├── config/ # Core LazyVim configs (autocmds, keymaps, options, lazy)
│       │       └── plugins/ # Plugin customizations
│       ├── nvim_simple/    # Neovim lean configuration (minimal setup)
│       │   ├── init.lua    # Entry point (loads vim_config, plugin, keys)
│       │   └── lua/
│       │       ├── vim_config.lua # Vim settings (leader, indentation, line numbers)
│       │       ├── keys.lua       # Custom keymaps
│       │       ├── plugin.lua     # Lazy.nvim bootstrap
│       │       └── plugins/       # Plugin specs (colorscheme, git, navigation, ui)
│       ├── ghostty/
│       │   ├── config      # Ghostty terminal config
│       │   └── shaders/    # Custom GLSL shaders
│       ├── tmux/
│       │   └── tmux.conf   # Tmux config with vim-tmux-navigator integration
│       ├── wezterm/
│       │   └── wezterm.lua # WezTerm terminal config
│       ├── herdr/
│       │   └── config.toml # Herdr agent multiplexer config
│       └── starship.toml   # Starship prompt config with custom palettes
├── AGENTS.md               # Project-specific agent instructions for this repo
├── CLAUDE.md -> AGENTS.md  # Symlink for Claude Code compatibility
└── README.md               # User-facing setup and usage docs
```

## Agent Configuration

Agent instructions managed at two levels:

**Project-level (this repo)**:
- `AGENTS.md` - Project-specific instructions for dotfiles repository
- `CLAUDE.md` - Symlink to AGENTS.md for Claude Code compatibility

**Global (all projects)**:
- `home/AGENTS.md` - Universal quality standards, commit preferences, bug fix workflows, engineering excellence rules
- `~/.claude/CLAUDE.md` - Symlink to ~/AGENTS.md for Claude Code compatibility

Setup global agent instructions:
```bash
ln -sf ~/Documents/Personal/dotfiles/home/AGENTS.md ~/AGENTS.md
ln -sf ~/AGENTS.md ~/.claude/CLAUDE.md
```

Claude Code resolution order:
1. Project-local ./CLAUDE.md (symlink -> ./AGENTS.md)
2. Global ~/.claude/CLAUDE.md (symlink -> ~/AGENTS.md -> ~/Documents/Personal/dotfiles/home/AGENTS.md)

Individual Claude Code config files symlinked from `home/.claude/` to `~/.claude/`:
- hooks/ - Event-driven shell commands (caveman mode, prompt validation)
- settings.json - Editor behavior, model preferences, feature flags
- settings.local.json - Machine-specific overrides
- statusline-command.sh - Custom terminal statusline

**Why individual files instead of entire directory?** ~/.claude/ contains runtime state managed by Claude Code (history.jsonl, debug/, session-env/, file-history/, cache/). Symlinking entire directory would write runtime state into version-controlled repo. Individual file symlinks keep configs in repo while runtime state stays local.

### Notification Hooks

Notification hooks (permission prompts, idle state, task completion) removed since herdr UI provides visual feedback. Re-enable in settings.json if running agents in background:

```json
"hooks": {
  "Notification": [
    {
      "matcher": "permission_prompt",
      "hooks": [{
        "type": "command",
        "command": "osascript -e 'display notification \"Permission needed\" with title \"Claude Code\" sound name \"Tink\"'"
      }]
    },
    {
      "matcher": "idle_prompt",
      "hooks": [{
        "type": "command",
        "command": "osascript -e 'display notification \"Ready for input\" with title \"Claude Code\" sound name \"Morse\"'"
      }]
    }
  ],
  "Stop": [{
    "hooks": [{
      "type": "command",
      "command": "osascript -e 'display notification \"Task completed\" with title \"Claude Code\" sound name \"Glass\"'"
    }]
  }]
}


## Development Workflows

### Neovim Configuration

Two configs available:

#### nvim (LazyVim - Full Featured)

LazyVim-based setup. Plugin configs live in `home/.config/nvim/lua/plugins/`:
- `colorscheme.lua` - Theme selection (vscode, kanagawa available)
- `explorer.lua` - File explorer settings
- `lsp.lua` - LSP configurations
- `vim-tmux-navigator.lua` - Seamless tmux/vim pane navigation
- `hotreload.lua` - Auto-reload nvim on config changes
- `image.lua` - Image rendering in terminal

Custom keymaps in `home/.config/nvim/lua/config/keymaps.lua`. LazyVim default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

#### nvim_simple (Lean Minimal)

Minimal setup with essential plugins only. Structure:
- `lua/vim_config.lua` - Core settings (leader=space, 2-space indent, hybrid line numbers, case-smart search)
- `lua/keys.lua` - Custom keymaps (Esc to save, Ctrl+a select all, paste preserving clipboard)
- `lua/plugin.lua` - Lazy.nvim bootstrap
- `lua/plugins/` - Plugin specs:
  - `colorscheme.lua` - Rose Pine Moon theme with transparency
  - `git.lua` - Neogit + Gitsigns for Git integration
  - `navigation.lua` - Oil.nvim file explorer + Snacks.nvim picker/search
  - `ui.lua` - which-key for keybinding hints

Key bindings:
- `<leader>e` - Open Oil.nvim file explorer
- `<leader>g` - Open Neogit
- `<leader>f` - File picker (Snacks)
- `<leader>s` - Text search (Snacks)
- `<leader>b` - Buffer navigation (Snacks)
- `gd` - Jump to LSP definition

Switch between configs by changing nvim symlink target in ~/.config/nvim.

### Tmux Configuration

Prefix: `Ctrl+Space` (not default Ctrl+b)

Key patterns:
- `prefix + r` - Reload config from ~/.config/tmux/tmux.conf
- `v` - Vertical split (preserves current path)
- `s` - Horizontal split (preserves current path)
- Vim-style copy mode bindings (v/V/y)
- `Ctrl+h/j/k/l` - Navigate between vim/tmux panes seamlessly (vim-tmux-navigator)

Plugins managed by tpm (Tmux Plugin Manager):
- christoomey/vim-tmux-navigator
- catppuccin/tmux@v2.1.0 (visual only, colors overridden by VSCode Dark+ palette)

Terminal features:
- 256 color + RGB support
- Passthrough enabled for Kitty graphics protocol (image.nvim support)
- Extended keys with CSI-u format for better modifier key support

### Shell Environment

Zsh with:
- Starship prompt (config in starship.toml)
- nvm for Node.js version management
- Bun runtime
- zsh-syntax-highlighting with Catppuccin Macchiato theme

### Herdr Configuration

Agent multiplexer config at `home/.config/herdr/config.toml` (symlinked to `~/.config/herdr/config.toml`).

Prefix: `Ctrl+Space` (matches tmux)

Key patterns (tmux-style):
- `prefix + ?` - Help menu
- `prefix + shift+s` - Settings (moved to make room for splits)
- `prefix + c` - New tab
- `prefix + v` - Vertical split (matches tmux)
- `prefix + s` - Horizontal split (matches tmux)
- `prefix + h/j/k/l` - Focus pane left/down/up/right
- `prefix + w` - Workspace picker
- `prefix + g` - Goto
- `prefix + shift+r` - Reload config

UI settings:
- `agent_panel_sort = "spaces"` - Group agents by workspace

Reload config without restart:
```bash
herdr server reload-config
```

Default config generated via `herdr --default-config`.

### Theme Development

Multiple theme palettes defined in home/.config/starship.toml:
- `vscode_dark_plus` (active)
- `catppuccin_mocha`
- `kanagawa`
- `gruvbox_dark`

When switching themes system-wide:
1. Update Neovim colorscheme in `home/.config/nvim/lua/plugins/colorscheme.lua`
2. Update tmux pane border colors in `home/.tmux.conf`
3. Update Ghostty palette in `home/.config/ghostty/config`
4. Update starship palette in `home/.config/starship.toml` (line 29: `palette = '...'`)

## Key Integration Points

**Vim-Tmux Navigation**: Seamless pane switching between Neovim and Tmux using `Ctrl+h/j/k/l`. Both tools configured for this integration:
- Tmux: Uses christoomey/vim-tmux-navigator plugin
- Neovim: Plugin config in `home/.config/nvim/lua/plugins/vim-tmux-navigator.lua`

**Extended Keys**: Tmux and Ghostty both configured for extended keys (CSI-u format) to support modern terminal capabilities and better modifier key handling.

**Graphics Protocol**: Tmux passthrough enabled, allows image.nvim to render images in terminal via Kitty graphics protocol.

## No Build/Test Commands

This is a dotfiles repository. No compilation, linting, or test commands. Changes typically applied by:
- Neovim: Auto-reloads on config save (hotreload.lua)
- Tmux: `prefix + r` to source ~/.config/tmux/tmux.conf
- Herdr: `herdr server reload-config` or `prefix + shift+r`
- Shell: `source ~/.zshrc` or restart terminal
- Ghostty: Automatically reloads config
- WezTerm: Automatically reloads config
