Set-StrictMode -Version Latest

$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction'] = 'Stop'

if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Host "Installing scoop..."
  Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

@(
  "ghq",
  "peco"
) | ForEach-Object {
  scoop install $_
}
