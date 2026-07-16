# Dotfiles

Personal macOS development environment configuration. Unified VSCode Dark+ theme across terminal, editor, and shell.

## What's Included

- **Neovim** - Two configs available: `nvim` (full LazyVim) and `nvim_simple` (minimal lean setup)
- **Tmux** - Terminal multiplexer with vim-style navigation
- **Ghostty** - Terminal emulator
- **Herdr** - Agent multiplexer with tmux-style keybindings
- **Shell** - Zsh with Starship prompt
- **Claude Code** - Settings, hooks, and agent instructions

## Prerequisites

Install via Homebrew:

```bash
# Core tools
brew install neovim tmux zsh starship

# Terminal emulators (choose one)
brew install --cask ghostty
# or: brew install --cask wezterm

# Agent multiplexer
brew install herdr

# Optional: Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Optional: Node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Optional: Bun runtime
curl -fsSL https://bun.sh/install | bash
```

## Setup

Clone this repo, then create symlinks:

```bash
# Replace <path_to_dotfiles> with actual path (e.g., ~/Documents/Personal/dotfiles)
DOTFILES=<path_to_dotfiles>

# Shell configs
ln -sf $DOTFILES/home/.bashrc ~/.bashrc
ln -sf $DOTFILES/home/.zshrc ~/.zshrc

# Create config directories
mkdir -p ~/.config/tmux ~/.config/wezterm ~/.config/herdr ~/.claude

# Neovim (choose one)
# Option 1: Full LazyVim setup
ln -sf $DOTFILES/home/.config/nvim ~/.config/nvim

# Option 2: Minimal lean config
# ln -sf $DOTFILES/home/.config/nvim_simple ~/.config/nvim

# Other configs
ln -sf $DOTFILES/home/.config/ghostty ~/.config/ghostty
ln -sf $DOTFILES/home/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -sf $DOTFILES/home/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -sf $DOTFILES/home/.config/starship.toml ~/.config/starship.toml
ln -sf $DOTFILES/home/.config/herdr/config.toml ~/.config/herdr/config.toml

# Claude Code (individual files, not entire directory)
ln -sf $DOTFILES/home/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf $DOTFILES/home/.claude/hooks ~/.claude/hooks
ln -sf $DOTFILES/home/.claude/settings.json ~/.claude/settings.json
ln -sf $DOTFILES/home/.claude/settings.local.json ~/.claude/settings.local.json
ln -sf $DOTFILES/home/.claude/statusline-command.sh ~/.claude/statusline-command.sh
```

Verify symlinks created:

```bash
ls -la ~ | grep "^l"
ls -la ~/.config | grep "^l"
ls -la ~/.claude | grep "^l"
```

## Key Features

### Unified Theme

VSCode Dark+ theme across entire stack:
- Neovim colorscheme
- Tmux pane borders
- Ghostty terminal palette
- Starship prompt colors

### Seamless Navigation

`Ctrl+h/j/k/l` navigates between Neovim and Tmux panes without switching mental models.

### Dual Neovim Configs

Switch between full-featured LazyVim (`nvim`) and minimal lean setup (`nvim_simple`):

```bash
# Switch to minimal config
rm ~/.config/nvim
ln -sf $DOTFILES/home/.config/nvim_simple ~/.config/nvim

# Switch back to full config
rm ~/.config/nvim
ln -sf $DOTFILES/home/.config/nvim ~/.config/nvim
```

## Usage

### Neovim

**nvim (LazyVim):**
- Leader: `Space`
- File explorer: `<leader>e`
- Find files: `<leader>ff`
- Live grep: `<leader>sg`

LazyVim keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

**nvim_simple:**
- Leader: `Space`
- File explorer: `<leader>e` (Oil.nvim)
- Git: `<leader>g` (Neogit)
- Find files: `<leader>f`
- Search text: `<leader>s`
- Buffers: `<leader>b`

### Tmux

Prefix: `Ctrl+Space`

- `prefix + r` - Reload config
- `prefix + v` - Vertical split
- `prefix + s` - Horizontal split
- `Ctrl+h/j/k/l` - Navigate panes (works with Neovim)
- `prefix + [` - Copy mode

### Herdr

Prefix: `Ctrl+Space` (matches Tmux)

- `prefix + ?` - Help
- `prefix + c` - New tab
- `prefix + v` - Vertical split
- `prefix + s` - Horizontal split
- `prefix + h/j/k/l` - Navigate panes
- `prefix + w` - Workspace picker
- `prefix + shift+r` - Reload config

### Shell

Starship prompt active by default. NVM and Bun loaded automatically (if installed).

## Customization

### Local Overrides

Create `~/.claude/settings.local.json` for machine-specific Claude Code settings without affecting version control.

### Theme Switching

Alternative themes available in `starship.toml`:
- `vscode_dark_plus` (active)
- `catppuccin_mocha`
- `kanagawa`
- `gruvbox_dark`

Change line 29 in `starship.toml` to switch.

### Tmux Plugins

Install Tmux plugins after setup:
1. Open Tmux
2. Press `prefix + I` (capital i) to install plugins via tpm

## Troubleshooting

### Symlinks not working

Check target paths match your clone location:
```bash
readlink ~/.zshrc  # Should point to your dotfiles/home/.zshrc
```

### Neovim plugins not loading

Run `:Lazy sync` inside Neovim to install/update plugins.

### Tmux prefix not responding

Check for conflicting keybindings. Default prefix is `Ctrl+Space`, not `Ctrl+b`.

### Colors look wrong

Ensure terminal supports true color:
```bash
# Should show smooth color gradient
curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
```

## Structure

```
.
├── home/
│   ├── .bashrc
│   ├── .zshrc
│   ├── .claude/          # Claude Code configs
│   └── .config/
│       ├── nvim/         # Full LazyVim config
│       ├── nvim_simple/  # Minimal lean config
│       ├── ghostty/
│       ├── tmux/
│       ├── wezterm/
│       ├── herdr/
│       └── starship.toml
├── CLAUDE.md             # Agent instructions
└── README.md             # This file
```

## License

Personal dotfiles. Use at your own risk.
