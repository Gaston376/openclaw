@echo off
echo Deploy Minimal OpenClaw to Hugging Face
echo ========================================
echo.
echo This will deploy only essential files (no images/binaries)
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0deploy-minimal.ps1"
