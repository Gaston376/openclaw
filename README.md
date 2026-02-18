---
title: OpenClaw AI Gateway
emoji: 🦞
colorFrom: blue
colorTo: purple
sdk: docker
sdk_version: "22"
app_port: 7860
pinned: false
license: mit
---

# 🦞 OpenClaw AI Gateway

Multi-channel AI gateway with extensible messaging integrations. Connect your AI assistants to Telegram, Discord, Slack, WhatsApp, and more.

## Features

- 🤖 Multi-provider AI support (Anthropic, OpenAI, Google, AWS Bedrock)
- 💬 Multiple messaging channels (Telegram, Discord, Slack, Signal, iMessage, WhatsApp)
- 🌐 Web UI for configuration and chat
- 🔒 Secure authentication with tokens and passwords
- 🔌 Extensible plugin system
- 📱 Mobile apps (iOS & Android)

## Quick Start

1. Access the web UI at your Space URL
2. Configure your AI provider API keys in Settings
3. Set up your preferred messaging channels
4. Start chatting!

## Configuration

Set these environment variables in your Space settings:

### Authentication (strongly recommended, choose at least one)
- `OPENCLAW_GATEWAY_TOKEN` - API authentication token
- `OPENCLAW_GATEWAY_PASSWORD` - Web UI password

> Without auth configured, your gateway will be publicly accessible to anyone with the URL.

### AI Providers (at least one required)
- `ANTHROPIC_API_KEY` - For Claude models
- `OPENAI_API_KEY` - For GPT models
- `GOOGLE_API_KEY` - For Gemini models

### Messaging Channels (optional)
- `TELEGRAM_BOT_TOKEN` - Telegram bot token
- `DISCORD_BOT_TOKEN` - Discord bot token
- `SLACK_BOT_TOKEN` - Slack bot token

## Documentation

- Full docs: https://docs.openclaw.ai
- GitHub: https://github.com/openclaw/openclaw
- Deployment guide: See `HUGGINGFACE_DEPLOYMENT.md` in the repo

## Support

- Issues: https://github.com/openclaw/openclaw/issues
- Discussions: https://github.com/openclaw/openclaw/discussions

---

Built with ❤️ by the OpenClaw community
