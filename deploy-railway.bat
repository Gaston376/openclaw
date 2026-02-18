@echo off
echo ========================================
echo Deploy OpenClaw to Railway.app
echo ========================================
echo.

REM Check if Railway CLI is installed
where railway >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Railway CLI not found!
    echo.
    echo Please install Railway CLI first:
    echo   PowerShell: iwr https://railway.app/install.ps1 ^| iex
    echo   Or download: https://github.com/railwayapp/cli/releases
    echo.
    pause
    exit /b 1
)

echo Step 1: Checking Railway login status...
railway whoami >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo You are not logged in to Railway.
    echo.
    echo Opening browser to login...
    railway login
    if %ERRORLEVEL% NEQ 0 (
        echo Login failed!
        pause
        exit /b 1
    )
)
echo   [OK] Logged in to Railway
echo.

echo Step 2: Using Railway Dockerfile...
if exist Dockerfile.railway (
    copy /Y Dockerfile.railway Dockerfile >nul
    echo   [OK] Using Dockerfile.railway
) else (
    echo   [WARN] Dockerfile.railway not found, using existing Dockerfile
)
echo.

echo Step 3: Initializing Railway project...
railway init
if %ERRORLEVEL% NEQ 0 (
    echo   [WARN] Project may already exist, continuing...
)
echo.

echo Step 4: Deploying to Railway...
echo   This will take 3-5 minutes...
echo.
railway up
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo   [ERROR] Deployment failed!
    echo   Check the error messages above.
    pause
    exit /b 1
)
echo.

echo ========================================
echo Deployment successful!
echo ========================================
echo.
echo Next steps:
echo 1. Get your app URL: railway domain
echo 2. Set environment variables in Railway dashboard:
echo    - ANTHROPIC_API_KEY or OPENAI_API_KEY (required)
echo    - OPENCLAW_GATEWAY_TOKEN (optional)
echo.
echo View your project: railway open
echo View logs: railway logs
echo.
pause
