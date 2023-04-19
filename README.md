# dotfiles

[![CI](https://github.com/h3y6e/dotfiles/actions/workflows/ci.yaml/badge.svg)](https://github.com/h3y6e/dotfiles/actions/workflows/ci.yaml)

## Installation

### darwin
```shell
brew install chezmoi
chezmoi init --apply h3y6e
```

### other
```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply h3y6e
```
