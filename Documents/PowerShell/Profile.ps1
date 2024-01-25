Set-PSReadLineOption -EditMode Emacs

# chezmoi
if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
  Set-Alias cz chezmoi
  function czc { code -n $(chezmoi source-path) }
}

# eza
if (Get-Command eza -ErrorAction SilentlyContinue) {
  function l { eza -a }
  function ll { eza -lh }
  function la { eza -lha }
}

# git
Set-Alias gti git

# ghq
if ((Get-Command ghq -ErrorAction SilentlyContinue) -and (Get-Command peco -ErrorAction SilentlyContinue)) {
  function g {
    $dir = ghq list | peco
    if (![string]::IsNullOrEmpty($dir)) {
      $path = (ghq root) + "/$dir"
      Set-Location -LiteralPath $path
    }
  }

  if (Get-Command code -ErrorAction SilentlyContinue) {
    function c {
      $dir = ghq list | peco
      if (![string]::IsNullOrEmpty($dir)) {
        $path = (ghq root) + "/$dir"
        code -n $path
      }
    }
  }
}

# inshellisense
if (Test-Path "$env:USERPROFILE\.inshellisense\key-bindings-powershell.ps1" -PathType Leaf) {
  . "$env:USERPROFILE\.inshellisense\key-bindings-powershell.ps1"
}

# fnm
if (Get-Command fnm -ErrorAction SilentlyContinue) {
  fnm completions --shell power-shell | Out-String | Invoke-Expression
  fnm env --use-on-cd | Out-String | Invoke-Expression
}
