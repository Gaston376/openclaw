@echo off
echo ========================================
echo Deploy OpenClaw to Railway
echo ========================================
echo.

set RAILWAY=C:\Users\Dell\AppData\Local\Railway\railway.exe

echo Using Railway Dockerfile...
copy /Y railway\Dockerfile Dockerfile >nul
copy /Y railway\railway.json railway.json >nul
echo [OK] Configuration ready
echo.

echo Deploying from root directory...
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
    echo View logs:
    echo   %RAILWAY% logs
    echo.
    echo Open dashboard:
    echo   %RAILWAY% open
    echo.
) else (
    echo.
    echo Deployment failed!
    echo.
    echo View logs:
    echo   %RAILWAY% logs
    echo.
)

pause
