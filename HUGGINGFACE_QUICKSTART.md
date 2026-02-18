# 🦞 OpenClaw on Hugging Face - Quick Start

## 1. Prepare Your Repository

```bash
# Check what files you have
bash check-files.sh

# Use the simplest Dockerfile (recommended for first deployment)
cp Dockerfile.simple Dockerfile
```

This uses the simplest Dockerfile that:
- ✅ Works with or without pnpm-lock.yaml
- ✅ Creates missing directories automatically
- ✅ Has fallback commands
- ✅ Configured for Hugging Face (port 7860)

## 2. Create Hugging Face Space

1. Go to https://huggingface.co/new-space
2. Settings:
   - **Name**: `openclaw-gateway`
   - **SDK**: Docker
   - **Visibility**: Public or Private

## 3. Deploy

```bash
# Clone your Space
git clone https://huggingface.co/spaces/YOUR_USERNAME/openclaw-gateway
cd openclaw-gateway

# Copy OpenClaw files
cp -r /path/to/openclaw/* .

# Commit and push
git add .
git commit -m "Deploy OpenClaw AI Gateway"
git push
```

## 4. Configure Environment Variables

In your Space settings (⚙️ Settings → Repository secrets):

### Required
```
ANTHROPIC_API_KEY=sk-ant-...
# OR
OPENAI_API_KEY=sk-...
```

### Recommended (Security)
```
OPENCLAW_GATEWAY_TOKEN=your-random-token-here
```

Generate a secure token:
```bash
# Linux/Mac
openssl rand -hex 32

# Or use any random string generator
```

## 5. Access Your Gateway

Once the build completes (~5-10 minutes):
- URL: `https://YOUR_USERNAME-openclaw-gateway.hf.space`
- Login with your `OPENCLAW_GATEWAY_TOKEN` (if set)

## Troubleshooting

### Build Error: "not found" (ui/package.json, patches, etc.)

**Problem**: Required files weren't pushed to Hugging Face.

**Solution**:
```bash
# Run preparation script
bash .huggingface-prepare.sh

# If it creates .gitignore.huggingface:
cp .gitignore.huggingface .gitignore

# Force add required files
git add -f pnpm-lock.yaml ui/package.json patches/ scripts/

# Push again
git commit -m "Add required files"
git push
```

### Build Fails
- Check build logs in Space
- Ensure Node.js 22+ is used (Dockerfile handles this)
- Verify all files were copied

### Can't Access Gateway
- Check Space is running (not sleeping)
- Verify port 7860 is configured
- Check environment variables are set

### Authentication Issues
- Set `OPENCLAW_GATEWAY_TOKEN` in Space secrets
- Or use `OPENCLAW_GATEWAY_PASSWORD` for password auth

## Next Steps

1. Configure AI models in the web UI
2. Set up messaging channels (Telegram, Discord, etc.)
3. Start chatting with your AI assistant!

## Full Documentation

- Complete guide: `HUGGINGFACE_DEPLOYMENT.md`
- Dependencies: `DEPENDENCIES.md`
- OpenClaw docs: https://docs.openclaw.ai

---

Need help? Open an issue: https://github.com/openclaw/openclaw/issues
