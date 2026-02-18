# Install Railway CLI for Windows
# ================================

$ErrorActionPreference = "Stop"

Write-Host "Installing Railway CLI..." -ForegroundColor Cyan
Write-Host ""

# Get latest release info
$repo = "railwayapp/cli"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"

try {
    Write-Host "Fetching latest version..." -ForegroundColor Yellow
    $release = Invoke-RestMethod -Uri $apiUrl
    $version = $release.tag_name
    Write-Host "  Latest version: $version" -ForegroundColor Green
    
    # Find Windows AMD64 asset
    $asset = $release.assets | Where-Object { $_.name -like "*windows_amd64.exe" }
    
    if (-not $asset) {
        Write-Host "  [ERROR] Windows executable not found in release!" -ForegroundColor Red
        exit 1
    }
    
    $downloadUrl = $asset.browser_download_url
    Write-Host "  Download URL: $downloadUrl" -ForegroundColor Cyan
    
    # Download to temp location
    $tempFile = Join-Path $env:TEMP "railway.exe"
    Write-Host ""
    Write-Host "Downloading Railway CLI..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempFile
    Write-Host "  [OK] Downloaded to: $tempFile" -ForegroundColor Green
    
    # Install location
    $installDir = Join-Path $env:LOCALAPPDATA "Railway"
    if (-not (Test-Path $installDir)) {
        New-Item -ItemType Directory -Path $installDir -Force | Out-Null
    }
    
    $installPath = Join-Path $installDir "railway.exe"
    
    Write-Host ""
    Write-Host "Installing to: $installPath" -ForegroundColor Yellow
    Move-Item -Path $tempFile -Destination $installPath -Force
    Write-Host "  [OK] Installed" -ForegroundColor Green
    
    # Add to PATH if not already there
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath -notlike "*$installDir*") {
        Write-Host ""
        Write-Host "Adding to PATH..." -ForegroundColor Yellow
        [Environment]::SetEnvironmentVariable(
            "Path",
            "$userPath;$installDir",
            "User"
        )
        Write-Host "  [OK] Added to PATH" -ForegroundColor Green
        Write-Host "  [INFO] Restart your terminal for PATH changes to take effect" -ForegroundColor Cyan
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Railway CLI installed successfully!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Installed at: $installPath" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Close and reopen your terminal"
    Write-Host "2. Run: railway login"
    Write-Host "3. Run: cd railway"
    Write-Host "4. Run: deploy.bat"
    Write-Host ""
    
} catch {
    Write-Host ""
    Write-Host "[ERROR] Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Manual installation:" -ForegroundColor Yellow
    Write-Host "1. Go to: https://github.com/railwayapp/cli/releases/latest"
    Write-Host "2. Download: railway_windows_amd64.exe"
    Write-Host "3. Rename to: railway.exe"
    Write-Host "4. Move to: C:\Windows\System32\"
    Write-Host ""
    exit 1
}

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
