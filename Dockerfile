FROM node:22-bookworm

WORKDIR /app

# Copy package files first
COPY package.json pnpm-workspace.yaml .npmrc ./
COPY pnpm-lock.yaml* ./

# Enable corepack for pnpm
RUN corepack enable

# Install dependencies
RUN pnpm install --no-frozen-lockfile

# Copy source code
COPY . .

# Create dummy A2UI bundle to satisfy build
RUN mkdir -p src/canvas-host/a2ui && \
    echo "// Placeholder" > src/canvas-host/a2ui/a2ui.bundle.js && \
    echo "placeholder" > src/canvas-host/a2ui/.bundle.hash

# Build the project
RUN pnpm build

# Build UI
RUN pnpm ui:build || echo "UI build skipped"

ENV NODE_ENV=production

# Railway provides PORT env variable
EXPOSE ${PORT:-8080}

# Start the gateway
CMD ["sh", "-c", "node openclaw.mjs gateway --allow-unconfigured --bind lan --port ${PORT:-8080}"]
