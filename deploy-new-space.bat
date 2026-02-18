@echo off
echo Deploy OpenClaw to NEW Hugging Face Space
echo ===========================================
echo.
echo Target: Gaston895/new-Space
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0deploy-new-space.ps1"
