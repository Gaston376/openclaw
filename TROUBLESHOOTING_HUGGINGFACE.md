# Hugging Face Deployment Troubleshooting

## Build Error: Files Not Found

### Symptom
```
ERROR: failed to calculate checksum of ref: "/ui/package.json": not found
ERROR: failed to calculate checksum of ref: "/patches": not found
```

### Cause
Required files weren't pushed to your Hugging Face Space repository.

### Solution

**Step 1: Check what files you have**
```bash
bash check-files.sh
```

**Step 2: Use the simplest Dockerfile**
```bash
cp Dockerfile.simple Dockerfile
```

**Step 3: Ensure all files are committed**
```bash
# Check what's tracked
git ls-files

# If files are missing, add them
git add -f ui/ src/ scripts/ patches/
git add -f pnpm-lock.yaml package.json openclaw.mjs

# Commit
git commit -m "Add all required files"

# Push
git push
```

---

## Build Error: pnpm-lock.yaml Missing

### Symptom
Build fails because `pnpm-lock.yaml` is not found.

### Cause
The file is in `.gitignore` and wasn't pushed.

### Solution

**Option 1: Use Dockerfile that doesn't need it**
```bash
cp Dockerfile.simple Dockerfile
git add Dockerfile
git commit -m "Use simple Dockerfile"
git push
```

**Option 2: Force add the lock file**
```bash
git add -f pnpm-lock.yaml
git commit -m "Add pnpm-lock.yaml"
git push
```

---

## Build Error: Build Command Fails

### Symptom
```
RUN pnpm build
ERROR: process exited with code 1
```

### Cause
Build script failed during compilation.

### Solution

**Check the full build logs** in your Hugging Face Space to see the actual error.

Common issues:
- Missing dependencies
- TypeScript errors
- Out of memory

**Quick fix: Use emergency Dockerfile**
```bash
cp Dockerfile.emergency Dockerfile
git add Dockerfile
git commit -m "Use emergency Dockerfile"
git push
```

This Dockerfile continues even if build fails.

---

## Build Error: Out of Memory

### Symptom
```
FATAL ERROR: Reached heap limit Allocation failed
```

### Cause
Hugging Face free tier has limited memory.

### Solution

**Option 1: Upgrade your Space**
- Go to Space settings
- Upgrade to a paid tier with more RAM

**Option 2: Reduce build memory usage**
Add to Dockerfile before build:
```dockerfile
ENV NODE_OPTIONS="--max-old-space-size=4096"
```

---

## Gateway Not Accessible After Build

### Symptom
Build succeeds but can't access the gateway.

### Cause
- Wrong port
- Not binding to 0.0.0.0
- Missing environment variables

### Solution

**Check Dockerfile CMD line:**
```dockerfile
CMD ["node", "openclaw.mjs", "gateway", "--allow-unconfigured", "--bind", "lan", "--port", "7860"]
```

Must have:
- `--port 7860` (Hugging Face default)
- `--bind lan` (binds to 0.0.0.0)

**Check environment variables:**
- At least one AI provider key must be set
- `ANTHROPIC_API_KEY` or `OPENAI_API_KEY`

---

## Authentication Issues

### Symptom
Can't login to the gateway.

### Cause
No authentication configured.

### Solution

Set in Space settings → Repository secrets:
```
OPENCLAW_GATEWAY_TOKEN=your-random-token-here
```

Generate a token:
```bash
openssl rand -hex 32
```

---

## Space Keeps Sleeping

### Symptom
Space goes to sleep after inactivity.

### Cause
Free tier Spaces sleep after 48 hours of inactivity.

### Solution

**Option 1: Upgrade to paid tier**
- Always-on Spaces available with paid plans

**Option 2: Use uptime monitoring**
- Sign up at https://uptimerobot.com (free)
- Add HTTP monitor for your Space URL
- Set interval to 5 minutes

---

## Complete File Checklist

Before pushing to Hugging Face, ensure these files exist:

### Required Files
- [ ] `package.json`
- [ ] `pnpm-workspace.yaml`
- [ ] `.npmrc`
- [ ] `openclaw.mjs`
- [ ] `README.md` (with frontmatter)
- [ ] `Dockerfile`

### Required Directories
- [ ] `src/` (source code)
- [ ] `ui/` (web UI)
- [ ] `scripts/` (build scripts)
- [ ] `patches/` (can be empty)

### Optional but Recommended
- [ ] `pnpm-lock.yaml` (dependencies)
- [ ] `.dockerignore` (optimize build)

---

## Dockerfile Decision Tree

**First time deploying?**
→ Use `Dockerfile.simple`

**Build failing with "not found" errors?**
→ Use `Dockerfile.simple` or `Dockerfile.emergency`

**Build succeeding but want optimization?**
→ Use `Dockerfile.huggingface.minimal`

**Everything working and want best caching?**
→ Use `Dockerfile.huggingface`

---

## Getting Help

1. **Check build logs** in your Space
2. **Run check-files.sh** to verify files
3. **Try Dockerfile.simple** first
4. **Check environment variables** are set
5. **Open an issue**: https://github.com/openclaw/openclaw/issues

Include in your issue:
- Full build logs
- Output of `git ls-files`
- Which Dockerfile you're using
- Your Space URL (if public)

---

## Quick Recovery

If everything is broken and you just want it to work:

```bash
# 1. Use the emergency Dockerfile
cp Dockerfile.emergency Dockerfile

# 2. Ensure README has frontmatter
head -n 12 README.md  # Should show YAML frontmatter

# 3. Add everything
git add -A

# 4. Commit and push
git commit -m "Emergency deployment fix"
git push

# 5. Set environment variables in Space settings
# - ANTHROPIC_API_KEY or OPENAI_API_KEY
# - OPENCLAW_GATEWAY_TOKEN (optional but recommended)
```

Wait 5-10 minutes for build to complete.

---

Last Updated: 2026-02-14
