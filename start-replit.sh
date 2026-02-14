#!/bin/bash
set -e

echo "🦞 Starting OpenClaw on Replit..."
echo "=================================="

# Set PORT if not already set by Replit
export PORT=${PORT:-3000}

echo "📦 Installing pnpm globally..."
npm install -g pnpm 2>/dev/null || echo "pnpm already installed"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📥 Installing dependencies (first time - this may take a few minutes)..."
    pnpm install
else
    echo "✅ Dependencies already installed"
fi

# Check if dist exists
if [ ! -d "dist" ]; then
    echo "🔨 Building OpenClaw (first time - this may take a few minutes)..."
    pnpm build
    echo "🎨 Building UI..."
    pnpm ui:build
else
    echo "✅ Build already complete"
fi

echo ""
echo "🚀 Starting OpenClaw Gateway..."
echo "   Port: $PORT"
echo "   Bind: lan (0.0.0.0)"
echo "   Mode: production"
echo ""
echo "🌐 Once started, click the 'Webview' button above to access the UI"
echo "=================================="
echo ""

# Start the gateway
exec node openclaw.mjs gateway --allow-unconfigured --bind lan --port $PORT
