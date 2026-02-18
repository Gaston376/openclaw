#!/bin/bash

echo "🔍 Checking OpenClaw files for Hugging Face deployment"
echo "======================================================"
echo ""

# Required files
echo "📋 Required files:"
files=(
    "package.json"
    "pnpm-workspace.yaml"
    ".npmrc"
    "openclaw.mjs"
    "ui/package.json"
    "README.md"
    "Dockerfile"
)

all_present=true
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✓ $file"
    else
        echo "   ❌ $file (MISSING)"
        all_present=false
    fi
done

echo ""
echo "📁 Required directories:"
dirs=(
    "src"
    "ui"
    "scripts"
    "patches"
)

for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        file_count=$(find "$dir" -type f 2>/dev/null | wc -l)
        echo "   ✓ $dir/ ($file_count files)"
    else
        echo "   ❌ $dir/ (MISSING)"
        all_present=false
    fi
done

echo ""
echo "🔒 Lock file:"
if [ -f "pnpm-lock.yaml" ]; then
    size=$(wc -c < pnpm-lock.yaml)
    echo "   ✓ pnpm-lock.yaml ($size bytes)"
else
    echo "   ⚠️  pnpm-lock.yaml (MISSING - will be generated during build)"
fi

echo ""
if [ "$all_present" = true ]; then
    echo "✅ All required files present!"
    echo ""
    echo "📤 To push to Hugging Face:"
    echo "   git add ."
    echo "   git commit -m 'Deploy OpenClaw'"
    echo "   git push"
else
    echo "❌ Some required files are missing!"
    echo ""
    echo "Please ensure all files are present before pushing to Hugging Face."
fi

echo ""
echo "💡 Tip: If files are missing, they might be in .gitignore"
echo "   Check: cat .gitignore"
echo ""
