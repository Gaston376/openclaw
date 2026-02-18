#!/bin/bash
set -e

echo "🦞 OpenClaw - Hugging Face Spaces Setup"
echo "========================================"
echo ""

# Check if we're in the openclaw directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run this script from the openclaw root directory."
    exit 1
fi

# Backup original files
echo "📦 Backing up original files..."
if [ -f "Dockerfile" ] && [ ! -f "Dockerfile.original" ]; then
    cp Dockerfile Dockerfile.original
    echo "   ✓ Backed up Dockerfile to Dockerfile.original"
fi

# Use Hugging Face optimized Dockerfile
echo "🐳 Setting up Hugging Face Dockerfile..."
if [ -f "Dockerfile.huggingface" ]; then
    cp Dockerfile.huggingface Dockerfile
    echo "   ✓ Using Dockerfile.huggingface as Dockerfile"
else
    echo "   ⚠️  Dockerfile.huggingface not found, using existing Dockerfile"
fi

# Verify README.md has Hugging Face frontmatter
echo "📄 Checking README.md..."
if head -n 1 README.md | grep -q "^---$"; then
    echo "   ✓ README.md has Hugging Face frontmatter"
else
    echo "   ⚠️  README.md missing frontmatter. Please check README.md"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Create a new Docker Space on Hugging Face: https://huggingface.co/new-space"
echo "2. Clone your Space: git clone https://huggingface.co/spaces/YOUR_USERNAME/SPACE_NAME"
echo "3. Copy files: cp -r . /path/to/your/space/"
echo "4. Configure environment variables in Space settings:"
echo "   - OPENCLAW_GATEWAY_TOKEN (recommended)"
echo "   - ANTHROPIC_API_KEY or OPENAI_API_KEY (required)"
echo "5. Push: git add . && git commit -m 'Deploy OpenClaw' && git push"
echo ""
echo "📚 Full guide: HUGGINGFACE_DEPLOYMENT.md"
echo ""
