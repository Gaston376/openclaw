FROM node:22-bookworm

WORKDIR /app

# Copy everything
COPY . .

# Enable corepack for pnpm
RUN corepack enable

# Install ALL dependencies (including devDependencies for tsx)
RUN pnpm install --no-frozen-lockfile

# Set to development to keep devDependencies available
ENV NODE_ENV=development

# Railway provides PORT env variable (default to 8080 if not set)
ENV PORT=8080

# Set dummy API key to allow gateway to start (Railway will override with real keys)
ENV ANTHROPIC_API_KEY=sk-ant-dummy-key-for-railway-healthcheck

# Expose the port
EXPOSE 8080

# Healthcheck to verify the gateway is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD node -e "require('http').get('http://localhost:' + process.env.PORT + '/', (r) => process.exit(r.statusCode === 200 ? 0 : 1))"

# Run directly from TypeScript source using tsx (no build step needed)
# Bind to 0.0.0.0 to accept connections from Railway's proxy
CMD sh -c "node --import tsx openclaw.mjs gateway --allow-unconfigured --bind 0.0.0.0 --port $PORT"
