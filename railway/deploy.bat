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
    echo Install with PowerShell:
    echo   iwr https://railway.app/install.ps1 ^| iex
    echo.
    echo Or download from:
    echo   https://github.com/railwayapp/cli/releases
    echo.
    pause
    exit /b 1
)

echo [OK] Railway CLI found
echo.

echo Checking login status...
railway whoami >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Not logged in. Opening browser...
    railway login
    if %ERRORLEVEL% NEQ 0 (
        echo Login failed!
        pause
        exit /b 1
    )
)
echo [OK] Logged in
echo.

echo Deploying to Railway...
echo This will take 3-5 minutes...
echo.

railway up

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Deployment successful!
    echo ========================================
    echo.
    echo Get your URL:
    echo   railway domain
    echo.
    echo View logs:
    echo   railway logs
    echo.
    echo Open dashboard:
    echo   railway open
    echo.
    echo Set environment variables in the Railway dashboard:
    echo   - ANTHROPIC_API_KEY or OPENAI_API_KEY
    echo   - OPENCLAW_GATEWAY_TOKEN (optional)
    echo.
) else (
    echo.
    echo Deployment failed!
    echo Check the error messages above.
    echo.
)

pause
