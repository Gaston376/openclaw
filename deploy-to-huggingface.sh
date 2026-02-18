#!/bin/bash
set -e

echo "🦞 OpenClaw - Deploy to Hugging Face"
echo "====================================="
echo ""

# Configuration
HF_SPACE="Gaston895/opengsstec"
HF_SPACE_URL="https://huggingface.co/spaces/$HF_SPACE"
HF_TOKEN="${HF_TOKEN:-}"

# Check if token is provided
if [ -z "$HF_TOKEN" ]; then
    echo "❌ Error: HF_TOKEN environment variable not set"
    echo ""
    echo "Usage:"
    echo "  export HF_TOKEN='your-token-here'"
    echo "  bash deploy-to-huggingface.sh"
    echo ""
    echo "Or:"
    echo "  HF_TOKEN='your-token-here' bash deploy-to-huggingface.sh"
    exit 1
fi

echo "📋 Step 1: Preparing files..."

# Use the simple Dockerfile
if [ -f "Dockerfile.simple" ]; then
    cp Dockerfile.simple Dockerfile
    echo "   ✓ Using Dockerfile.simple"
else
    echo "   ⚠️  Dockerfile.simple not found, using existing Dockerfile"
fi

# Verify README has frontmatter
if [ -f "README.md" ]; then
    if head -n 1 README.md | grep -q "^---$"; then
        echo "   ✓ README.md has frontmatter"
    else
        echo "   ⚠️  README.md missing frontmatter"
    fi
else
    echo "   ❌ README.md not found!"
    exit 1
fi

echo ""
echo "🔧 Step 2: Setting up git remote..."

# Remove existing huggingface remote if it exists
git remote remove huggingface 2>/dev/null || true

# Add Hugging Face remote with token
git remote add huggingface "https://Gaston895:${HF_TOKEN}@huggingface.co/spaces/${HF_SPACE}"
echo "   ✓ Added Hugging Face remote"

echo ""
echo "📦 Step 3: Preparing commit..."

# Check if there are changes to commit
if git diff --quiet && git diff --cached --quiet; then
    echo "   ℹ️  No changes to commit"
else
    # Stage all changes
    git add -A
    echo "   ✓ Staged all changes"
    
    # Commit
    git commit -m "Deploy OpenClaw to Hugging Face" || echo "   ℹ️  Nothing to commit"
fi

echo ""
echo "🚀 Step 4: Pushing to Hugging Face..."

# Push to Hugging Face
if git push huggingface main --force; then
    echo "   ✓ Successfully pushed to Hugging Face!"
else
    # Try master branch if main fails
    echo "   ⚠️  Push to 'main' failed, trying 'master'..."
    if git push huggingface master --force; then
        echo "   ✓ Successfully pushed to Hugging Face!"
    else
        echo "   ❌ Push failed!"
        exit 1
    fi
fi

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📊 Next steps:"
echo "1. Visit your Space: $HF_SPACE_URL"
echo "2. Wait for build to complete (~5-10 minutes)"
echo "3. Check build logs if there are errors"
echo "4. Set environment variables in Space settings:"
echo "   - ANTHROPIC_API_KEY or OPENAI_API_KEY (required)"
echo "   - OPENCLAW_GATEWAY_TOKEN (recommended for security)"
echo ""
echo "🔗 Your Space: $HF_SPACE_URL"
echo ""

# Clean up - remove the remote to avoid exposing token
git remote remove huggingface 2>/dev/null || true
