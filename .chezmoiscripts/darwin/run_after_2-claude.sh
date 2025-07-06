#!/bin/bash

set -Eeufo pipefail

claude config set -g parallelTasksCount 3
claude mcp add playwright npx @playwright/mcp@latest -s user
claude mcp add --transport sse context7 https://mcp.context7.com/sse -s user
claude mcp add --transport sse figma http://127.0.0.1:3845/sse -s user
