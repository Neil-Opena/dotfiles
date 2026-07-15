# ~/.zshrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/neilopena/.bun/_bun" ] && source "/Users/neilopena/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ghostty
export PATH="/Applications/Ghostty.app/Contents/MacOS:$PATH"

# zsh-syntax-highlighting
if [ ! -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  if command -v brew &> /dev/null; then
    echo "Installing zsh-syntax-highlighting..."
    brew install zsh-syntax-highlighting
  fi
fi

if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-autosuggestions
if [ ! -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  if command -v brew &> /dev/null; then
    echo "Installing zsh-autosuggestions..."
    brew install zsh-autosuggestions
  fi
fi

if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^f' autosuggest-accept  # Ctrl+f accepts suggestion
fi

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

# Shell aliases
alias ..="cd .."
alias add="git add ."
alias push="git push"
alias pull="git pull"
alias m="git switch main"
alias cc="claude --dangerously-skip-permissions"
alias co="codex --full-auto"

# Auto-start herdr (only if not already in herdr)
if command -v herdr &> /dev/null; then
    # Check parent process - if it's herdr, we're already inside
    if ! ps -o comm= -p $PPID 2>/dev/null | grep -q herdr; then
        herdr
    fi
fi
