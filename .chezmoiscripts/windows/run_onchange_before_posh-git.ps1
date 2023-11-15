if ($null -eq $(Get-Module -ListAvailable -Name posh-git)) {
  Write-Host "Installing posh-git..."
  Install-Module -Name posh-git -Scope CurrentUser -Force
}
