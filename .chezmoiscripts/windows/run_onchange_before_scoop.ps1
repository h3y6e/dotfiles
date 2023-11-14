if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Host "Installing scoop..."
  irm get.scoop.sh | iex
}
