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
Import-Module posh-git

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

# completions
Get-ChildItem "$PROFILE\..\Completions\" | ForEach-Object {
  . $_.FullName
}
