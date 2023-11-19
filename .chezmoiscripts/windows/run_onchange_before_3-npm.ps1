Set-StrictMode -Version Latest

$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction'] = 'Stop'

function Test-CommandExists {
  param($command)
  $exists = $false
  if (Get-Command $command -ErrorAction SilentlyContinue) {
    $exists = $true
  }
  return $exists
}

Write-Host -ForegroundColor Magenta "npm installing..."
$env:PATH += ";C:\Program Files\nodejs;$env:USERPROFILE\AppData\Roaming\npm"

if (-not (Test-CommandExists "inshellisense")) {
  Write-Host "installing inshellisense..."
  npm install -g @microsoft/inshellisense
  inshellisense bind
}
