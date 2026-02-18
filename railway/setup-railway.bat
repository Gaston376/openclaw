@echo off
echo ========================================
echo Setup Railway CLI
echo ========================================
echo.

set SOURCE=railway-v4.30.3-x86_64-pc-windows-gnu\railway.exe
set DEST=%LOCALAPPDATA%\Railway

echo Checking for Railway executable...
if not exist "%SOURCE%" (
    echo ERROR: Railway executable not found at:
    echo   %SOURCE%
    echo.
    echo Please extract the Railway CLI archive first.
    pause
    exit /b 1
)

echo [OK] Found Railway CLI
echo.

echo Creating installation directory...
if not exist "%DEST%" (
    mkdir "%DEST%"
)
echo [OK] Directory ready: %DEST%
echo.

echo Copying railway.exe...
copy /Y "%SOURCE%" "%DEST%\railway.exe" >nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Copied to: %DEST%\railway.exe
) else (
    echo [ERROR] Failed to copy file
    pause
    exit /b 1
)
echo.

echo Adding to PATH...
setx PATH "%PATH%;%DEST%" >nul 2>&1
echo [OK] Added to PATH
echo.

echo ========================================
echo Railway CLI installed successfully!
echo ========================================
echo.
echo Installation location:
echo   %DEST%\railway.exe
echo.
echo IMPORTANT: Close and reopen your terminal for PATH changes to take effect.
echo.
echo Next steps:
echo   1. Close this terminal
echo   2. Open a new terminal
echo   3. Run: railway login
echo   4. Run: cd railway
echo   5. Run: deploy.bat
echo.
pause
