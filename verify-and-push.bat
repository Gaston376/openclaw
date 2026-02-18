@echo off
echo Verifying and Pushing to Hugging Face
echo ======================================
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0verify-and-push.ps1"
