# 🦞 OpenClaw on Hugging Face Spaces - Deployment Guide

## Quick Start (Automated Setup)

```bash
# Run the preparation script
bash .huggingface-prepare.sh

# Follow the on-screen instructions
```

The script will:
- Check all required files exist
- Handle pnpm-lock.yaml (ensure it's tracked)
- Configure the Hugging Face-optimized Dockerfile
- Verify README.md has proper frontmatter
- Show you next steps

**Important**: The script may create `.gitignore.huggingface` if `pnpm-lock.yaml` is excluded. You'll need to use it when pushing to Hugging Face.

---

## Manual Deployment Guide

## Quick Deploy to Hugging Face Spaces

### Prerequisites
- Hugging Face account (free): https://huggingface.co/join
- Git installed locally

### Important Notes
- OpenClaw is a **Node.js/TypeScript** project, not Python
- No `requirements.txt` needed - all dependencies are in `package.json`
- The Dockerfile handles all dependency installation automatically

### Step 1: Create a New Space

1. Go to https://huggingface.co/spaces
2. Click "Create new Space"
3. Configure your Space:
   - **Name**: `openclaw-gateway` (or your preferred name)
   - **License**: MIT
   - **Space SDK**: Docker
   - **Visibility**: Public or Private (your choice)
4. Click "Create Space"

### Step 2: Clone and Push

```bash
# Clone your new Space
git clone https://huggingface.co/spaces/YOUR_USERNAME/openclaw-gateway
cd openclaw-gateway

# Copy OpenClaw files
cp -r /path/to/openclaw/* .

# Important: Use the Hugging Face README
# The project includes README.md (for Hugging Face) and README.github.md (for GitHub)
# Make sure README.md has the Hugging Face frontmatter

# Add and commit
git add .
git commit -m "Initial OpenClaw deployment"

# Push to Hugging Face
git push
```

**Note**: The repository includes two README files:
- `README.md` - Configured for Hugging Face Spaces (with YAML frontmatter)
- `README.github.md` - Original GitHub README (for reference)

### Step 3: Configure Environment Variables

In your Space settings (Settings → Repository secrets), add:

**Authentication (choose one or both):**
```
OPENCLAW_GATEWAY_TOKEN=your-secret-token-here
# OR
OPENCLAW_GATEWAY_PASSWORD=your-secure-password-here
```

> **Important**: While technically optional with `--allow-unconfigured`, setting at least one auth method is **strongly recommended** for public deployments. Without auth, anyone with your Space URL can access your gateway.

**AI Provider Keys (at least one required):**
```
ANTHROPIC_API_KEY=your-anthropic-key
OPENAI_API_KEY=your-openai-key
```

### Step 4: Access Your Gateway

Once the build completes (5-10 minutes):
- Your gateway will be available at: `https://YOUR_USERNAME-openclaw-gateway.hf.space`
- The web UI will be accessible at the same URL

---

## Dockerfile Options

The repository includes multiple Dockerfiles for different scenarios:

### Option 1: Dockerfile.simple (Recommended for first-time deployment)
Simplest version, most forgiving:
```bash
cp Dockerfile.simple Dockerfile
```
- Copies all files at once
- Generates lock file if missing
- Fallback commands if build fails

### Option 2: Dockerfile.huggingface.minimal
Balanced approach:
```bash
cp Dockerfile.huggingface.minimal Dockerfile
```
- Creates missing directories
- Handles missing files gracefully
- Optimized for Hugging Face

### Option 3: Dockerfile.huggingface
Full-featured (requires all files present):
```bash
cp Dockerfile.huggingface Dockerfile
```
- Best caching
- Requires pnpm-lock.yaml
- Requires all directories present

**For your first deployment, use Dockerfile.simple**

---

## Alternative: Direct Git Push Method

If you already have the OpenClaw repo:

```bash
# Add Hugging Face as a remote
git remote add hf https://huggingface.co/spaces/YOUR_USERNAME/openclaw-gateway

# Push to Hugging Face
git push hf main
```

---

## Configuration

### Set Gateway Credentials

Environment variables (set in Space settings):
- `OPENCLAW_GATEWAY_TOKEN`: Authentication token for API access
- `OPENCLAW_GATEWAY_PASSWORD`: Password for web UI login

### Add Messaging Channels

Add these environment variables for your preferred channels:

**Telegram:**
```
TELEGRAM_BOT_TOKEN=your-telegram-bot-token
```

**Discord:**
```
DISCORD_BOT_TOKEN=your-discord-bot-token
```

**Slack:**
```
SLACK_BOT_TOKEN=your-slack-bot-token
SLACK_SIGNING_SECRET=your-slack-signing-secret
```

---

## Persistent Storage

Hugging Face Spaces provide persistent storage at `/data`:

The OpenClaw config will be stored at:
- `/data/.openclaw/` - Configuration and sessions

To preserve data across rebuilds, the Dockerfile should be updated to use `/data`:

```dockerfile
ENV HOME=/data
```

---

## Monitoring and Logs

- View logs in the Space's "Logs" tab
- Check build status in the "Building" section
- Monitor resource usage in Space settings

---

## Troubleshooting

### "not found" errors during build (ui/package.json, patches, etc.)

This happens when required files aren't pushed to Hugging Face.

**Solution:**
```bash
# Run the preparation script
bash .huggingface-prepare.sh

# If pnpm-lock.yaml is in .gitignore:
cp .gitignore.huggingface .gitignore

# Force add all required files
git add -f pnpm-lock.yaml ui/package.json patches/ scripts/

# Commit and push
git commit -m "Add all required files for Hugging Face"
git push
```

**Root cause**: The `.gitignore` file excludes `pnpm-lock.yaml`, but Docker needs it. The preparation script handles this.

### Build Fails
- Check the build logs in your Space
- Ensure all dependencies are in `package.json`
- Verify Node.js version compatibility (requires Node 22+)

### Gateway Not Accessible
- Verify the Space is running (not sleeping)
- Check that port 7860 is used in the CMD
- Ensure `--bind lan` is set (binds to 0.0.0.0)

### Out of Memory
- Hugging Face free tier has memory limits
- Consider upgrading to a paid Space for more resources
- Or optimize build process by reducing dependencies

---

## Keeping Space Awake

Free Spaces sleep after 48 hours of inactivity. To keep it awake:

1. Upgrade to a paid Space (always-on)
2. Use a monitoring service like UptimeRobot to ping your Space every 5 minutes

---

## Next Steps

1. ✅ Access the Web UI at your Space URL
2. ✅ Configure AI models (Anthropic/OpenAI)
3. ✅ Set up messaging channels
4. ✅ Start chatting with your AI assistant!

---

## Support

- Hugging Face Spaces docs: https://huggingface.co/docs/hub/spaces
- OpenClaw docs: https://docs.openclaw.ai
- Issues: https://github.com/openclaw/openclaw/issues

---

🎉 Enjoy your OpenClaw AI assistant on Hugging Face Spaces!
