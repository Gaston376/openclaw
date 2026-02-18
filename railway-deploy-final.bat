@echo off
echo ========================================
echo Deploy OpenClaw to Railway (Fixed)
echo ========================================
echo.

set RAILWAY=C:\Users\Dell\AppData\Local\Railway\railway.exe

echo Step 1: Copy Railway Dockerfile to root...
copy /Y Dockerfile.railway-fixed Dockerfile >nul
echo [OK] Dockerfile ready
echo.

echo Step 2: Link to Railway project...
%RAILWAY% link
echo.

echo Step 3: Deploy...
%RAILWAY% up

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Deployment successful!
    echo ========================================
    echo.
    echo Get your URL:
    %RAILWAY% domain
    echo.
) else (
    echo.
    echo Deployment failed! Check logs:
    %RAILWAY% logs
    echo.
)

pause
