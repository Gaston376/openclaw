FROM node:22-bookworm

WORKDIR /app

# First, copy everything (source code + package files)
COPY . .

# Enable corepack for pnpm
RUN corepack enable

# Install dependencies
RUN pnpm install --no-frozen-lockfile

# Create dummy A2UI bundle to satisfy build requirement
RUN mkdir -p src/canvas-host/a2ui && \
    echo "// Placeholder A2UI bundle" > src/canvas-host/a2ui/a2ui.bundle.js && \
    echo "placeholder" > src/canvas-host/a2ui/.bundle.hash

# Build the project
RUN pnpm build

# Build UI (optional, won't fail build if it errors)
RUN pnpm ui:build || echo "UI build skipped"

ENV NODE_ENV=production

# Railway provides PORT env variable
EXPOSE ${PORT:-8080}

# Start the gateway
CMD ["sh", "-c", "node openclaw.mjs gateway --allow-unconfigured --bind lan --port ${PORT:-8080}"]
