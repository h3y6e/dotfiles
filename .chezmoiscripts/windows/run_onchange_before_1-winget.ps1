Set-StrictMode -Version Latest

$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction'] = 'Stop'

@(
  "Microsoft.VisualStudioCode",
  "AgileBits.1Password",
  "Microsoft.PowerToys",
  "Git.Git",
  "Mozilla.Firefox.DeveloperEdition",
  "Notion.Notion",
  "eza-community.eza",
  "OpenJS.Nodejs.LTS"
) | ForEach-Object {
  winget install $_
}
