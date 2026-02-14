# 🦞 OpenClaw on Replit - Setup Guide

## Quick Setup (Copy these files to Replit)

### Step 1: Upload Files to Replit

1. Go to your Replit: https://replit.com/@gsstec/opengsstec
2. In the Files panel, upload these files from your local repository:
   - `.replit`
   - `start-replit.sh`

### Step 2: Make Script Executable

In Replit Shell, run:
```bash
chmod +x start-replit.sh
```

### Step 3: Click "Run" Button

Click the green "Run" button at the top of Replit.

### Step 4: Access Your Gateway

Once you see "Starting OpenClaw Gateway..." in the console:
1. Click the "Webview" button (appears at the top)
2. Or open the URL shown in the Webview panel

Your OpenClaw gateway will be accessible at:
```
https://opengsstec-gsstec.repl.co
```

---

## Alternative: Manual Setup (If files don't upload)

### Option A: Create files in Replit

1. **Create `.replit` file:**
   - Click "Add file" → name it `.replit`
   - Copy content from `.replit` in this repo

2. **Create `start-replit.sh` file:**
   - Click "Add file" → name it `start-replit.sh`
   - Copy content from `start-replit.sh` in this repo

3. **Make executable:**
   ```bash
   chmod +x start-replit.sh
   ```

4. **Click Run**

### Option B: Quick Command (No files needed)

In Replit Shell, run this one command:

```bash
npm install -g pnpm && pnpm install && pnpm build && pnpm ui:build && PORT=${PORT:-3000} node openclaw.mjs gateway --allow-unconfigured --bind lan --port $PORT
```

---

## Troubleshooting

### "Port already in use"
Stop the current process (Ctrl+C in Shell) and run again.

### "Cannot find module"
Run:
```bash
pnpm install
pnpm build
```

### "No webpage to preview"
Make sure the command includes `--port $PORT` (not `--port 18789`)

### Build takes too long
This is normal for first time. Subsequent runs will be faster.

---

## Configuration

### Change Gateway Token/Password

Edit `.replit` file and change:
```toml
OPENCLAW_GATEWAY_TOKEN = "your-custom-token"
OPENCLAW_GATEWAY_PASSWORD = "your-custom-password"
```

### Add Telegram Bot

Edit `.replit` file and add:
```toml
TELEGRAM_BOT_TOKEN = "your-telegram-bot-token"
```

---

## What's Running

- **Gateway Port**: Dynamic (set by Replit via $PORT)
- **Bind Address**: lan (0.0.0.0) - accessible from internet
- **Web UI**: Enabled
- **WebSocket**: Enabled
- **Auth**: Token + Password (set in .replit)

---

## Next Steps

1. ✅ Access the Web UI
2. ✅ Configure your AI models (Anthropic/OpenAI)
3. ✅ Set up messaging channels (Telegram, Discord, etc.)
4. ✅ Start chatting with your AI assistant!

---

## Keep Replit Awake (Optional)

Free Replit instances sleep after inactivity. To keep it awake:

1. Sign up at [UptimeRobot](https://uptimerobot.com) (free, no credit card)
2. Add HTTP(s) monitor
3. URL: `https://opengsstec-gsstec.repl.co`
4. Interval: 5 minutes

This will ping your Replit every 5 minutes to keep it awake.

---

## Support

If you encounter issues:
1. Check the Shell output for error messages
2. Try stopping (Ctrl+C) and running again
3. Clear cache: Delete `node_modules` and `dist` folders, then run again

---

🎉 Enjoy your OpenClaw AI assistant on Replit!
