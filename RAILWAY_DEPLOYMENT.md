# 🚂 Deploy OpenClaw to Railway.app

Railway.app is perfect for Docker deployments - no abuse flags, easy setup, generous free tier.

## Quick Deploy (5 minutes)

### Step 1: Sign Up for Railway

1. Go to: https://railway.app
2. Click "Login" → Sign in with GitHub
3. Verify your account (they may ask for a credit card for $5 free credit, but won't charge)

### Step 2: Install Railway CLI

**Windows (PowerShell):**
```powershell
iwr https://railway.app/install.ps1 | iex
```

**Or download manually:**
https://github.com/railwayapp/cli/releases

### Step 3: Login to Railway

```bash
railway login
```

This will open your browser to authenticate.

### Step 4: Deploy OpenClaw

Run the deployment script:
```bash
deploy-railway.bat
```

That's it! Railway will:
- Create a new project
- Build your Docker image
- Deploy the app
- Give you a public URL

---

## Manual Deployment (Alternative)

### Option A: Deploy from GitHub

1. Push your code to GitHub (if not already)
2. Go to: https://railway.app/new
3. Click "Deploy from GitHub repo"
4. Select your repository
5. Railway auto-detects Dockerfile and deploys

### Option B: Deploy from Local

1. Create new project: `railway init`
2. Deploy: `railway up`
3. Add domain: `railway domain`

---

## Environment Variables

After deployment, set these in Railway dashboard:

**Required (at least one):**
```
ANTHROPIC_API_KEY=sk-ant-api03-...
OPENAI_API_KEY=sk-...
```

**Recommended:**
```
OPENCLAW_GATEWAY_TOKEN=<random-token>
PORT=8080
```

**To set variables:**
1. Go to your Railway project dashboard
2. Click on your service
3. Go to "Variables" tab
4. Add each variable

---

## Railway Configuration

Railway auto-detects your Dockerfile. No extra config needed!

But if you want custom settings, create `railway.json`:

```json
{
  "build": {
    "builder": "DOCKERFILE",
    "dockerfilePath": "Dockerfile"
  },
  "deploy": {
    "startCommand": "node openclaw.mjs gateway --allow-unconfigured --bind lan --port $PORT",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

---

## Pricing

**Free Tier:**
- $5 free credit (with credit card verification)
- 500 hours/month execution time
- 512MB RAM, 1GB disk
- Perfect for testing!

**Hobby Plan:** $5/month
- $5 credit included
- More resources
- Custom domains

---

## Your App URL

After deployment, Railway gives you a URL like:
```
https://openclaw-production.up.railway.app
```

You can also add a custom domain in the Railway dashboard.

---

## Advantages Over Hugging Face

✅ No abuse detection issues
✅ Faster deployments
✅ Better logging
✅ Automatic HTTPS
✅ Easy environment variables
✅ GitHub integration
✅ Generous free tier

---

## Troubleshooting

### Build Fails
- Check logs in Railway dashboard
- Verify Dockerfile is correct
- Ensure all files are present

### App Crashes
- Check environment variables are set
- View logs in Railway dashboard
- Verify port configuration (Railway uses $PORT)

### Out of Memory
- Upgrade to Hobby plan
- Or optimize build process

---

## Next Steps

1. Run `deploy-railway.bat`
2. Wait 3-5 minutes for build
3. Set environment variables in Railway dashboard
4. Access your app at the provided URL
5. Done! 🎉

---

**Ready to deploy? Run `deploy-railway.bat` now!**
