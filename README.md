# dotfiles

[![CI](https://github.com/h3y6e/dotfiles/actions/workflows/ci.yaml/badge.svg)](https://github.com/h3y6e/dotfiles/actions/workflows/ci.yaml)

## Install

### darwin
```zsh
brew install chezmoi
chezmoi init --apply h3y6e
```

### linux
```bash
/bin/bash -c "$(curl -fsLS dotfiles.heyh.ooo)" -- --remote
```

### windows
```ps1
(irm -useb https://get.chezmoi.io/ps1) | powershell -c -
.\bin\chezmoi.exe init --apply h3y6e
```

## Update
```zsh
cz update
```

## Edit
```zsh
czc
cz apply
```
