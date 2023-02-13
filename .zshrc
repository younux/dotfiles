# Add brew to PATH (ARM)
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

# Remove command lines from the history list when the first character on the line is a space
setopt HIST_IGNORE_SPACE

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

# Add nodejs 18 to PATH
export PATH="/opt/homebrew/opt/node@18/bin:$PATH" # ARM
export PATH="/usr/local/opt/node@18/bin:$PATH" # Intel

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

# Add helm completion
source <(helm completion zsh)

# Add function for dotfiles
dotfilesgit () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

