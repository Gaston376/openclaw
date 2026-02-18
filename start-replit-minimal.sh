#!/bin/bash
set -e

echo "🦞 Starting OpenClaw (Minimal Mode)..."

export PORT=${PORT:-3000}
export NODE_OPTIONS="--max-old-space-size=400"

# Skip UI build to save memory
if [ ! -d "dist" ]; then
    echo "Building (this will take time)..."
    npm install -g pnpm
    pnpm install --prod
    pnpm build
fi

echo "Starting gateway (minimal resources)..."
exec node openclaw.mjs gateway \
  --allow-unconfigured \
  --bind lan \
  --port $PORT
