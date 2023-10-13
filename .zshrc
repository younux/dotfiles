# Add brew to PATH (ARM)
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load homebrew environment variables
if command -v "brew" > /dev/null; then
  eval "$(brew shellenv)"
fi

# Use Starship
if command -v "starship" > /dev/null; then
  eval "$(starship init zsh)"
fi

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

# Add function for dotfiles
dotfilesgit () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

# Colorize ls
alias ls="ls --color=auto"

# Add ll alias
alias ll="ls -al"

# Add user local bin path
export PATH="${PATH}:$HOME/.local/bin"

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
if command -v "isengardcli" > /dev/null; then
  eval "$(isengardcli shell-autocomplete)"
fi

# Add aws cli completion
if command -v "aws_completer" > /dev/null; then
  complete -C aws_completer aws
fi

# Add kubectl completion
if command -v "kubectl" > /dev/null; then
  source <(kubectl completion zsh)
  # Add alias for kubectl and completion to this alias
  alias k=kubectl
  compdef __start_kubectl k
fi

# Add helm completion
if command -v "helm" > /dev/null; then
  source <(helm completion zsh)
fi

# Add docker host using Lima
if command -v limactl  > /dev/null; then
  export DOCKER_HOST=$(limactl list docker --format 'unix://{{.Dir}}/sock/docker.sock')
fi

# fzf configuration
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

# Display neoftech
if command -v "neofetch" > /dev/null; then
  neofetch --ascii_colors 7
fi

# Add pyenv configuration
if command -v "pyenv" > /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# Default GOPROXY is blocked at work
export GOPROXY="direct"
