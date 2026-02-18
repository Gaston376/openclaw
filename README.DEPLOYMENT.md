# 🚀 Quick Deploy to Hugging Face

## Fastest Way (Windows)

**Just double-click:**
```
deploy.bat
```

## Alternative Methods

**PowerShell:**
```powershell
.\deploy-to-huggingface.ps1
```

**Bash (Linux/Mac/WSL):**
```bash
bash deploy-to-huggingface.sh
```

## What Happens?

1. Uses the simplest, most reliable Dockerfile
2. Commits your changes
3. Pushes to: https://huggingface.co/spaces/Gaston895/opengsstec
4. Build takes ~10 minutes

## After Deploy

Set environment variables in Space settings:
- `ANTHROPIC_API_KEY` or `OPENAI_API_KEY` (required)
- `OPENCLAW_GATEWAY_TOKEN` (recommended)

## Your Space

- **Settings**: https://huggingface.co/spaces/Gaston895/opengsstec/settings
- **App** (after build): https://Gaston895-opengsstec.hf.space

## Need Help?

Read: `DEPLOYMENT_SUMMARY.md` or `TROUBLESHOOTING_HUGGINGFACE.md`

---

🎉 **Ready?** Run `deploy.bat` now!
