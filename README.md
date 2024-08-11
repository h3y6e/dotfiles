# dotfiles

[![CI](https://github.com/h3y6e/dotfiles/actions/workflows/ci.yaml/badge.svg)](https://github.com/h3y6e/dotfiles/actions/workflows/ci.yaml)

## Install

### darwin

```zsh
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install chezmoi
chezmoi init --apply h3y6e
```

### linux

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/h3y6e/dotfiles/main/install.sh)" -- --remote
```

### windows

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
winget install twpayne.chezmoi
chezmoi init --apply h3y6e
```

## Update

```zsh
cz update
```

## Edit

```zsh
czc # open the source path in vscode
cz apply
```

## Clear the state of chezmoiscipts

```zsh
# `run_once_` scripts
cz state delete-bucket --bucket=scriptState
# `run_onchange_` scripts
cz state delete-bucket --bucket=entryState
```
