#!/bin/bash
set -e

echo "🦞 Preparing OpenClaw for Hugging Face Deployment"
echo "=================================================="
echo ""

# Check if we're in the openclaw directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run this script from the openclaw root directory."
    exit 1
fi

echo "📋 Step 1: Checking required files..."

# Check for required files
REQUIRED_FILES=(
    "package.json"
    "pnpm-workspace.yaml"
    ".npmrc"
    "openclaw.mjs"
    "ui/package.json"
)

MISSING_FILES=()
for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        MISSING_FILES+=("$file")
        echo "   ❌ Missing: $file"
    else
        echo "   ✓ Found: $file"
    fi
done

if [ ${#MISSING_FILES[@]} -gt 0 ]; then
    echo ""
    echo "❌ Error: Missing required files. Cannot proceed."
    exit 1
fi

echo ""
echo "📦 Step 2: Ensuring pnpm-lock.yaml is tracked..."

# Remove pnpm-lock.yaml from .gitignore if present
if grep -q "^pnpm-lock.yaml" .gitignore 2>/dev/null; then
    echo "   ⚠️  pnpm-lock.yaml is in .gitignore"
    echo "   Creating .gitignore.huggingface without pnpm-lock.yaml..."
    grep -v "^pnpm-lock.yaml" .gitignore > .gitignore.huggingface
    echo "   ✓ Created .gitignore.huggingface"
    echo ""
    echo "   📝 Note: Use .gitignore.huggingface when pushing to Hugging Face:"
    echo "      cp .gitignore.huggingface .gitignore"
else
    echo "   ✓ pnpm-lock.yaml is not excluded"
fi

# Check if pnpm-lock.yaml exists
if [ ! -f "pnpm-lock.yaml" ]; then
    echo ""
    echo "⚠️  pnpm-lock.yaml not found. Generating it..."
    pnpm install
    echo "   ✓ Generated pnpm-lock.yaml"
fi

echo ""
echo "🐳 Step 3: Setting up Dockerfile..."

# Backup original Dockerfile if it exists
if [ -f "Dockerfile" ] && [ ! -f "Dockerfile.original" ]; then
    cp Dockerfile Dockerfile.original
    echo "   ✓ Backed up Dockerfile to Dockerfile.original"
fi

# Use Hugging Face Dockerfile
if [ -f "Dockerfile.huggingface" ]; then
    cp Dockerfile.huggingface Dockerfile
    echo "   ✓ Using Dockerfile.huggingface as Dockerfile"
else
    echo "   ⚠️  Dockerfile.huggingface not found"
fi

echo ""
echo "📄 Step 4: Verifying README.md..."

if [ ! -f "README.md" ]; then
    echo "   ❌ README.md not found!"
    exit 1
fi

if head -n 1 README.md | grep -q "^---$"; then
    echo "   ✓ README.md has Hugging Face frontmatter"
else
    echo "   ❌ README.md missing frontmatter!"
    echo "   Please ensure README.md starts with YAML frontmatter"
    exit 1
fi

echo ""
echo "✅ Preparation complete!"
echo ""
echo "📋 Files ready for Hugging Face:"
echo "   - README.md (with frontmatter)"
echo "   - Dockerfile (optimized for HF)"
echo "   - pnpm-lock.yaml (dependencies locked)"
echo "   - All source files"
echo ""
echo "🚀 Next steps:"
echo "1. If pnpm-lock.yaml was in .gitignore, run:"
echo "   cp .gitignore.huggingface .gitignore"
echo ""
echo "2. Add all files:"
echo "   git add ."
echo ""
echo "3. Commit:"
echo "   git commit -m 'Prepare for Hugging Face deployment'"
echo ""
echo "4. Push to Hugging Face:"
echo "   git push"
echo ""
echo "📚 Full guide: HUGGINGFACE_DEPLOYMENT.md"
echo ""
