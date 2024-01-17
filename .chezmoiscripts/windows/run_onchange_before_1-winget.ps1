Set-StrictMode -Version Latest

$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction'] = 'Stop'

@(
  "Microsoft.VisualStudioCode",
  "AgileBits.1Password",
  "Microsoft.PowerToys",
  "Git.Git",
  "GitHub.cli",
  "Mozilla.Firefox.DeveloperEdition",
  "Notion.Notion",
  "eza-community.eza",
  "OpenJS.Nodejs.LTS",
  "Discord.Discord",
  "SlackTechnologies.Slack",
  "Google.Chrome",
  "Docker.DockerDesktop",
  "Schniz.fnm"
) | ForEach-Object {
  winget install $_
}
