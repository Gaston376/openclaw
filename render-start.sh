#!/bin/bash
set -e

echo "Starting OpenClaw Gateway on Render.com..."
echo "Port: ${PORT:-18789}"
echo "Bind: lan"

# Start the gateway with Render-compatible settings
exec node openclaw.mjs gateway \
  --allow-unconfigured \
  --bind lan \
  --port "${PORT:-18789}" \
  --verbose
