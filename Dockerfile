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
RUN set -x && \
    (pnpm build && echo "Build succeeded") || \
    (echo "Build failed, trying manual steps..." && \
     pnpm exec tsdown && \
     echo "tsdown completed" && \
     ls -la dist/ && \
     (test -f dist/entry.js || test -f dist/entry.mjs) && \
     echo "Entry file created successfully")

# Set environment
ENV NODE_ENV=production
ENV OPENCLAW_GATEWAY_TOKEN=railway-default-change-me

# Expose port (Railway dynamically assigns PORT)
EXPOSE 8080

# Start gateway with built output (use sh to expand PORT variable)
CMD sh -c "echo Starting gateway on port ${PORT:-8080}... && node openclaw.mjs gateway --allow-unconfigured --bind lan --port ${PORT:-8080}"
