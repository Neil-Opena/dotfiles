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

# Catppuccin theme for zsh-syntax-highlighting (must be before loading the plugin)
source ~/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh

# zsh-syntax-highlighting (must be at end of .zshrc)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

