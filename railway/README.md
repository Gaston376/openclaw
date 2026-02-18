# Deploy OpenClaw to Railway.app

## Quick Start

1. **Install Railway CLI:**
   ```powershell
   iwr https://railway.app/install.ps1 | iex
   ```

2. **Login:**
   ```bash
   railway login
   ```

3. **Deploy:**
   ```bash
   cd railway
   railway up
   ```

## What's in this folder?

- `Dockerfile` - Railway-optimized Docker configuration
- `railway.json` - Railway deployment settings
- `.railwayignore` - Files to exclude from deployment
- `deploy.bat` - Windows deployment script
- `deploy.sh` - Linux/Mac deployment script

## Environment Variables

Set these in Railway dashboard after deployment:

**Required:**
- `ANTHROPIC_API_KEY` or `OPENAI_API_KEY`

**Optional:**
- `OPENCLAW_GATEWAY_TOKEN`

## Commands

```bash
# Deploy
railway up

# Get your URL
railway domain

# View logs
railway logs

# Open dashboard
railway open

# Set environment variable
railway variables set ANTHROPIC_API_KEY=sk-ant-...
```

## Your App

After deployment, your app will be at:
`https://your-project.up.railway.app`

Access the OpenClaw gateway at that URL!
