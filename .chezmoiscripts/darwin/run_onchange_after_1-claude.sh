#!/bin/bash

set -Eeufo pipefail

if command -v claude &> /dev/null && command -v node &> /dev/null; then
  claude config set -g autoUpdates disabled
  claude mcp remove playwright
  claude mcp add playwright npx @playwright/mcp@latest -s user
  claude mcp remove context7
  claude mcp add --transport http context7 https://mcp.context7.com/mcp -s user
  claude mcp remove figma
  claude mcp add --transport http figma http://127.0.0.1:3845/mcp -s user
  # claude mcp add --transport sse linear https://mcp.linear.app/sse -s user
fi
