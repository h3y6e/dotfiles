Set-StrictMode -Version Latest

$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction'] = 'Stop'

if ($null -eq $(Get-Module -ListAvailable -Name posh-git)) {
  Write-Host "Installing posh-git..."
  Install-Module -Name posh-git -Scope CurrentUser -Force
}
