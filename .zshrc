# Add brew to PATH (ARM)
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load brew environment variables
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
if [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# ZSH zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
if [ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

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

# Add user local bin directory to PATH
export PATH="${PATH}:$HOME/.local/bin"

# Define the base directory for user-specific configuration file (in macos)
# Used by lazygit and others
export XDG_CONFIG_HOME="$HOME/.config"

# Add Go bin directory to PATH
export PATH="${PATH}:/usr/local/go/bin"

# Add user Go bin directory to PATH
export PATH="${PATH}:$HOME/go/bin"

# Define default editor
export EDITOR=zed

# Add Rust to PATH
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
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

# Add docker host using Lima (replaced with colima)
# if command -v "limactl" > /dev/null && command -v "docker" > /dev/null; then
#   docker context create lima-docker --docker "host=$(limactl list docker --format 'unix://{{.Dir}}/sock/docker.sock')" > /dev/null 2>&1
#   docker context use lima-docker > /dev/null 2>&1
# fi

# Set up fzf key bindings and fuzzy completion
if command -v "fzf" > /dev/null; then
  source <(fzf --zsh)
  # fzf theme catppuccin mocha
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=separator:#CBA6F7 \
  --color=border:#6C7086,label:#CDD6F4"
fi

# Add nvm
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
fi

# Zellij welcome screen start function
if command -v "zellij" > /dev/null; then
    z(){
        # If welcome session exited, we need to delete it
        if zellij ls -n | grep -E '^welcome-session .*EXITED' >/dev/null; then
            zellij delete-session welcome-session # delete dead session
        fi
        # If welcome session is active, we attach to it
        if zellij ls -n | grep -E '^welcome-session ' >/dev/null; then
            zellij attach welcome-session
        else
        # We don't have a welcome session yet, we create it
            zellij --session welcome-session --new-session-with-layout welcome
        fi
    }
fi

# Yazi configuration
if command -v "yazi" > /dev/null; then
    # Use y to use yazi and change directory
    function y() {
    	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    	yazi "$@" --cwd-file="$tmp"
    	IFS= read -r -d '' cwd < "$tmp"
    	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    	rm -f -- "$tmp"
    }
fi