FROM node:22-bookworm

WORKDIR /app

# Copy everything
COPY . .

# Enable corepack for pnpm
RUN corepack enable

# Install dependencies
RUN pnpm install --no-frozen-lockfile

# Create a dummy A2UI bundle to satisfy the build requirement
RUN mkdir -p src/canvas-host/a2ui && \
    echo "// Placeholder A2UI bundle for Railway deployment" > src/canvas-host/a2ui/a2ui.bundle.js && \
    echo "placeholder" > src/canvas-host/a2ui/.bundle.hash

# Build the project
RUN pnpm build

# Set environment
ENV NODE_ENV=production
ENV PORT=8080
ENV OPENCLAW_GATEWAY_TOKEN=railway-default-change-me

# Expose port
EXPOSE 8080

# Start gateway with built output
CMD ["node", "openclaw.mjs", "gateway", "--allow-unconfigured", "--bind", "0.0.0.0", "--port", "8080"]
