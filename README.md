# dotfiles

My dotfiles repo

## Notes

- To clone the repo and files:

```
git clone --bare https://github.com/younux/dotfiles.git "$HOME/.dotfiles"
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" submodule update --init --recursive
dotfilesgit config --local status.showUntrackedFiles no
```

- Once the repo and files on your machine use the function `dotfilesgit` defined in `~/.zshrc` instead of `git` command to interact with the repo (bare repo):

```
dotfilesgit () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}
```

- To fetch latest changes from main branch

```
dotfilesgit fetch https://github.com/younux/dotfiles.git main:main
```

- To install brew packages

```
./config-scripts/brew-bundle-install.sh
```

- To create a Brewfile

```
./config-scripts/brew-bundle-dump.sh
```
