# Add brew to PATH
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Use Starship
eval "$(starship init zsh)"

# ZSH complete
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# ZSH zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Colorize ls
alias ls="ls --color=auto"

# Add ll alias
alias ll="ls -al"

# Add Go to PATH
export PATH="${PATH}:/usr/local/go/bin"

# Add user Go bin directory to PATH 
export PATH="${PATH}:$HOME/go/bin"

# Add Rust to PATH
source "$HOME/.cargo/env"

# Add isengard cli autocomplete 
if type "isengardcli" > /dev/null; then
  eval "$(isengardcli shell-autocomplete)"
fi

# Add aws cli completion
complete -C aws_completer aws

# Add kubectl completion 
source <(kubectl completion zsh)

# Add alias for kubectl and completion to this alias
alias k=kubectl
compdef __start_kubectl k

# Add function for dotfiles
dotfilesgit () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

