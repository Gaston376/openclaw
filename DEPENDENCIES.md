# OpenClaw Dependencies

## Core Dependencies (Required)

OpenClaw is a Node.js/TypeScript application. All core dependencies are managed via npm/pnpm.

### Runtime Requirements
- **Node.js**: 22.12.0 or higher (specified in `package.json` engines)
- **Package Manager**: pnpm 10.23.0 (specified in `package.json` packageManager)

### Installation
```bash
# Install pnpm globally
npm install -g pnpm

# Install all dependencies
pnpm install

# Build the project
pnpm build

# Build the UI
pnpm ui:build
```

## Docker Dependencies

The Dockerfile automatically installs all required dependencies:
- Node.js 22 (bookworm base image)
- Bun (for build scripts)
- pnpm (via corepack)
- All npm packages from `package.json`

No additional system packages are required for core functionality.

## Optional Dependencies

### Python (Optional - for specific skills only)

Some optional skills use Python scripts. These are NOT required for core gateway functionality.

**Python Version**: 3.10 or higher

**Skills that use Python:**
- `skills/openai-image-gen` - Image generation helper
- `skills/skill-creator` - Skill packaging utilities
- `skills/model-usage` - Usage statistics
- `skills/nano-banana-pro` - Image generation

**Python packages (if using these skills):**
```bash
# Only needed if you plan to use Python-based skills
pip install openai requests pillow
```

### Development Tools (Optional)

For development and testing:
```bash
# Security scanning
pip install detect-secrets==1.5.0

# LiteLLM proxy (optional provider)
pip install 'litellm[proxy]'
```

## Hugging Face Deployment

For Hugging Face Spaces deployment, you only need:
1. The Dockerfile (handles all dependencies automatically)
2. Environment variables for configuration
3. No additional requirements.txt needed

The Docker build process installs everything automatically.

## Platform-Specific Notes

### Windows
- Some build scripts use bash and may require WSL (Windows Subsystem for Linux)
- Or use Docker for a consistent build environment

### macOS
- Xcode Command Line Tools required for native builds
- Homebrew recommended for system dependencies

### Linux
- Standard build tools (gcc, make) required for native modules
- Docker is the recommended deployment method

## Dependency Management

- **JavaScript/TypeScript**: `package.json` + `pnpm-lock.yaml`
- **Patches**: `patches/` directory (pnpm patches)
- **Workspaces**: `pnpm-workspace.yaml` (monorepo structure)
- **UI**: Separate `ui/package.json`

## Security

- Dependencies are pinned in `pnpm-lock.yaml`
- Security overrides in `package.json` pnpm.overrides section
- Regular updates via Dependabot (see `.github/dependabot.yml`)

## Troubleshooting

### Missing Dependencies
```bash
# Clean install
rm -rf node_modules pnpm-lock.yaml
pnpm install
```

### Build Failures
```bash
# Ensure correct Node version
node --version  # Should be 22.12.0+

# Rebuild native modules
pnpm rebuild
```

### Docker Build Issues
```bash
# Clear Docker cache
docker build --no-cache -t openclaw .
```

---

For more information:
- Installation guide: `docs/install/`
- Docker deployment: `docs/install/docker.md`
- Development setup: `AGENTS.md`
