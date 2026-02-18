#!/bin/bash
set -e

echo "========================================"
echo "Deploy OpenClaw to Railway.app"
echo "========================================"
echo ""

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "ERROR: Railway CLI not found!"
    echo ""
    echo "Install with:"
    echo "  bash <(curl -fsSL cli.new)"
    echo ""
    echo "Or download from:"
    echo "  https://github.com/railwayapp/cli/releases"
    echo ""
    exit 1
fi

echo "[OK] Railway CLI found"
echo ""

echo "Checking login status..."
if ! railway whoami &> /dev/null; then
    echo "Not logged in. Opening browser..."
    railway login
fi
echo "[OK] Logged in"
echo ""

echo "Deploying to Railway..."
echo "This will take 3-5 minutes..."
echo ""

if railway up; then
    echo ""
    echo "========================================"
    echo "Deployment successful!"
    echo "========================================"
    echo ""
    echo "Get your URL:"
    echo "  railway domain"
    echo ""
    echo "View logs:"
    echo "  railway logs"
    echo ""
    echo "Open dashboard:"
    echo "  railway open"
    echo ""
    echo "Set environment variables in the Railway dashboard:"
    echo "  - ANTHROPIC_API_KEY or OPENAI_API_KEY"
    echo "  - OPENCLAW_GATEWAY_TOKEN (optional)"
    echo ""
else
    echo ""
    echo "Deployment failed!"
    echo "Check the error messages above."
    echo ""
    exit 1
fi
