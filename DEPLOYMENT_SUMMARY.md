# 🦞 OpenClaw Hugging Face Deployment - Ready to Go!

## ✅ Everything is Set Up

Your deployment is configured for:
- **Space**: Gaston895/opengsstec
- **URL**: https://huggingface.co/spaces/Gaston895/opengsstec
- **Token**: Configured in deployment scripts

## 🚀 Deploy NOW (Choose One)

### Option 1: Windows - Double Click (Easiest)
```
deploy.bat
```
Just double-click the file!

### Option 2: Windows PowerShell
```powershell
.\deploy-to-huggingface.ps1
```

### Option 3: Linux/Mac/WSL
```bash
bash deploy-to-huggingface.sh
```

## 📋 What the Script Does

1. ✅ Uses `Dockerfile.simple` (most reliable)
2. ✅ Commits all your changes
3. ✅ Pushes to Hugging Face Space
4. ✅ Shows you the Space URL
5. ✅ Cleans up (removes token from git config)

## ⏱️ Timeline

- **Deploy**: 30 seconds
- **Build**: 5-10 minutes
- **Total**: ~10 minutes until your gateway is live

## 🔧 After Deployment

### 1. Watch the Build
Visit: https://huggingface.co/spaces/Gaston895/opengsstec
- Click "Building" to see logs
- Wait for "Running" status

### 2. Set Environment Variables
Go to: Settings → Repository secrets

**Required (at least one):**
```
ANTHROPIC_API_KEY=sk-ant-api03-...
```
OR
```
OPENAI_API_KEY=sk-...
```

**Recommended (Security):**
```
OPENCLAW_GATEWAY_TOKEN=<random-32-char-string>
```

### 3. Access Your Gateway
Once running: https://Gaston895-opengsstec.hf.space

## 📁 Files Created for You

### Deployment Scripts
- `deploy.bat` - Windows quick deploy (double-click)
- `deploy-to-huggingface.ps1` - PowerShell script
- `deploy-to-huggingface.sh` - Bash script
- `.env.huggingface` - Token configuration

### Dockerfiles (in order of simplicity)
- `Dockerfile.simple` - ⭐ Used by default (most reliable)
- `Dockerfile.emergency` - If simple fails
- `Dockerfile.huggingface.minimal` - Balanced
- `Dockerfile.huggingface` - Full-featured

### Helper Scripts
- `check-files.sh` - Verify files before deploy
- `.huggingface-prepare.sh` - Prepare repository

### Documentation
- `DEPLOY_NOW.md` - Quick start guide
- `HUGGINGFACE_DEPLOYMENT.md` - Complete guide
- `HUGGINGFACE_QUICKSTART.md` - Quick reference
- `TROUBLESHOOTING_HUGGINGFACE.md` - Fix issues
- `DEPENDENCIES.md` - Dependency info

## 🆘 If Something Goes Wrong

### Build Fails?
1. Check logs in your Space
2. Read: `TROUBLESHOOTING_HUGGINGFACE.md`
3. Try: `cp Dockerfile.emergency Dockerfile` then deploy again

### Files Missing?
```bash
bash check-files.sh
```

### Need Different Dockerfile?
```bash
# Try emergency version
cp Dockerfile.emergency Dockerfile

# Then deploy again
deploy.bat  # or your preferred method
```

## 🔐 Security Notes

- ✅ Token is in `.env.huggingface` (gitignored)
- ✅ Scripts remove token from git config after push
- ✅ Token is only used during deployment
- ⚠️ Don't commit `.env.huggingface` to public repos

## 📊 Monitoring Your Space

### Check Status
- Space page: https://huggingface.co/spaces/Gaston895/opengsstec
- Build logs: Click "Building" tab
- App: Click "App" tab when running

### Keep It Awake (Free Tier)
Free Spaces sleep after 48h inactivity.

**Solution**: Use UptimeRobot (free)
1. Sign up: https://uptimerobot.com
2. Add HTTP monitor
3. URL: https://Gaston895-opengsstec.hf.space
4. Interval: 5 minutes

## 🎯 Quick Reference

```bash
# Deploy
deploy.bat                          # Windows
.\deploy-to-huggingface.ps1        # PowerShell
bash deploy-to-huggingface.sh      # Bash

# Check files
bash check-files.sh

# Change Dockerfile
cp Dockerfile.simple Dockerfile     # Default
cp Dockerfile.emergency Dockerfile  # If fails

# View logs
# Visit Space → Building tab
```

## 📞 Support

- Troubleshooting: `TROUBLESHOOTING_HUGGINGFACE.md`
- OpenClaw Docs: https://docs.openclaw.ai
- Issues: https://github.com/openclaw/openclaw/issues
- Your Space: https://huggingface.co/spaces/Gaston895/opengsstec

---

## 🎉 Ready to Deploy!

Just run:
```
deploy.bat
```

Or your preferred deployment method from above.

Your OpenClaw AI gateway will be live in ~10 minutes! 🚀

---

Last Updated: 2026-02-14
Space: Gaston895/opengsstec
