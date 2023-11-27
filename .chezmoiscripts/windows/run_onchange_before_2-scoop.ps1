Set-StrictMode -Version Latest

$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction'] = 'Stop'

if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Host "Installing scoop..."
  Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

@(
  "main/ghq",
  "main/peco",
  "nerd-fonts/FiraCode",
  "nerd-fonts/JetBrains-Mono"
) | ForEach-Object {
  scoop install $_
}
