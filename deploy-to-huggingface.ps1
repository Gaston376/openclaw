# OpenClaw - Deploy to Hugging Face (PowerShell)
# ================================================

$ErrorActionPreference = "Continue"  # Don't stop on non-critical errors

Write-Host "OpenClaw - Deploy to Hugging Face" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$HF_SPACE = "Gaston895/opengsstec"
$HF_SPACE_URL = "https://huggingface.co/spaces/$HF_SPACE"
$HF_TOKEN = $env:HF_TOKEN

# Check if token is provided
if ([string]::IsNullOrEmpty($HF_TOKEN)) {
    Write-Host "ERROR: HF_TOKEN environment variable not set" -ForegroundColor Red
    Write-Host ""
    Write-Host "Usage:"
    Write-Host '  $env:HF_TOKEN = "your-token-here"'
    Write-Host "  .\deploy-to-huggingface.ps1"
    Write-Host ""
    exit 1
}

Write-Host "Step 1: Preparing files..." -ForegroundColor Yellow

# Use the simple Dockerfile
if (Test-Path "Dockerfile.simple") {
    Copy-Item "Dockerfile.simple" "Dockerfile" -Force
    Write-Host "  [OK] Using Dockerfile.simple" -ForegroundColor Green
} else {
    Write-Host "  [WARN] Dockerfile.simple not found, using existing Dockerfile" -ForegroundColor Yellow
}

# Verify README has frontmatter
if (Test-Path "README.md") {
    $firstLine = Get-Content "README.md" -First 1
    if ($firstLine -eq "---") {
        Write-Host "  [OK] README.md has frontmatter" -ForegroundColor Green
    } else {
        Write-Host "  [WARN] README.md missing frontmatter" -ForegroundColor Yellow
    }
} else {
    Write-Host "  [ERROR] README.md not found!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Step 2: Setting up git remote..." -ForegroundColor Yellow

# Remove existing huggingface remote if it exists (ignore errors)
try {
    git remote remove huggingface 2>&1 | Out-Null
} catch {
    # Ignore - remote doesn't exist
}

# Add Hugging Face remote with token
$remoteUrl = "https://Gaston895:${HF_TOKEN}@huggingface.co/spaces/${HF_SPACE}"
git remote add huggingface $remoteUrl 2>&1 | Out-Null
Write-Host "  [OK] Added Hugging Face remote" -ForegroundColor Green

Write-Host ""
Write-Host "Step 3: Preparing commit..." -ForegroundColor Yellow

# Check if there are changes to commit
$status = git status --porcelain
if ([string]::IsNullOrEmpty($status)) {
    Write-Host "  [INFO] No changes to commit" -ForegroundColor Cyan
} else {
    # Stage all changes
    git add -A
    Write-Host "  [OK] Staged all changes" -ForegroundColor Green
    
    # Commit
    try {
        git commit -m "Deploy OpenClaw to Hugging Face" 2>$null
        Write-Host "  [OK] Created commit" -ForegroundColor Green
    } catch {
        Write-Host "  [INFO] Nothing to commit" -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "Step 4: Pushing to Hugging Face..." -ForegroundColor Yellow

# Push to Hugging Face
$pushed = $false
try {
    git push huggingface main --force 2>&1 | Out-Null
    Write-Host "  [OK] Successfully pushed to Hugging Face!" -ForegroundColor Green
    $pushed = $true
} catch {
    Write-Host "  [WARN] Push to 'main' failed, trying 'master'..." -ForegroundColor Yellow
    try {
        git push huggingface master --force 2>&1 | Out-Null
        Write-Host "  [OK] Successfully pushed to Hugging Face!" -ForegroundColor Green
        $pushed = $true
    } catch {
        Write-Host "  [ERROR] Push failed!" -ForegroundColor Red
    }
}

# Clean up - remove the remote to avoid exposing token
git remote remove huggingface 2>$null | Out-Null

if ($pushed) {
    Write-Host ""
    Write-Host "Deployment complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Visit your Space: $HF_SPACE_URL"
    Write-Host "2. Wait for build to complete (~5-10 minutes)"
    Write-Host "3. Check build logs if there are errors"
    Write-Host "4. Set environment variables in Space settings:"
    Write-Host "   - ANTHROPIC_API_KEY or OPENAI_API_KEY (required)"
    Write-Host "   - OPENCLAW_GATEWAY_TOKEN (recommended for security)"
    Write-Host ""
    Write-Host "Your Space: $HF_SPACE_URL" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "Deployment failed. Please check the errors above." -ForegroundColor Red
    exit 1
}
