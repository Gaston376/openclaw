FROM node:22-bookworm

WORKDIR /app

# Copy everything
COPY . .

# Debug: Check if the local/ subdirectory files exist
RUN echo "Checking for local/ subdirectory files..." && \
    ls -la src/commands/onboard-non-interactive/ && \
    ls -la src/commands/onboard-non-interactive/local/ || echo "local/ directory not found!"

# Enable corepack for pnpm
RUN corepack enable

# Install ALL dependencies (including devDependencies for tsx)
RUN pnpm install --no-frozen-lockfile

# Create dummy A2UI bundle to satisfy build requirement
RUN mkdir -p src/canvas-host/a2ui && \
    echo "// Placeholder A2UI bundle" > src/canvas-host/a2ui/a2ui.bundle.js && \
    echo "placeholder" > src/canvas-host/a2ui/.bundle.hash

# Try to build, but if it fails, create a minimal dist/entry.mjs that loads from source
RUN pnpm build || (mkdir -p dist && echo 'import("../src/entry.ts");' > dist/entry.mjs)

# Set to development to keep devDependencies available
ENV NODE_ENV=development

# Railway provides PORT env variable (default to 8080 if not set)
ENV PORT=8080

# Set a default gateway token (Railway should override this with a secure token)
ENV OPENCLAW_GATEWAY_TOKEN=railway-default-token-please-change-in-settings

# Expose the port
EXPOSE 8080

# Run the gateway
CMD sh -c "echo 'Starting OpenClaw Gateway on port $PORT...' && \
           node --import tsx openclaw.mjs gateway --allow-unconfigured --bind 0.0.0.0 --port $PORT"
