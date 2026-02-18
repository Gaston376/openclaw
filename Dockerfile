FROM node:22-bookworm

WORKDIR /app

# Copy everything
COPY . .

# Enable corepack for pnpm
RUN corepack enable

# Install ALL dependencies (including devDependencies for tsx)
RUN pnpm install --no-frozen-lockfile

ENV NODE_ENV=development

# Railway provides PORT env variable (default to 8080 if not set)
ENV PORT=8080

# Expose the port
EXPOSE 8080

# Run directly from TypeScript source using tsx (no build step needed)
# Bind to 0.0.0.0 to accept connections from Railway's proxy
CMD sh -c "node --import tsx openclaw.mjs gateway --allow-unconfigured --bind 0.0.0.0 --port $PORT"
