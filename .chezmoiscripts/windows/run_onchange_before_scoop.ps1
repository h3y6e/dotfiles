if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Host "Installing scoop..."
  Invoke-RestMethod get.scoop.sh | Invoke-Expression
}
