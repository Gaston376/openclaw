FROM node:22-bookworm

WORKDIR /app

# Copy everything from current directory
COPY . .

# Go to parent directory where the actual source is
WORKDIR /app/..

# Enable corepack for pnpm
RUN corepack enable

# Create patches directory if needed
RUN mkdir -p patches

# Install dependencies
RUN pnpm install --no-frozen-lockfile

# Build the project
RUN pnpm build

# Build UI
RUN pnpm ui:build

ENV NODE_ENV=production

# Railway provides PORT env variable
EXPOSE ${PORT:-8080}

# Start the gateway
CMD node openclaw.mjs gateway --allow-unconfigured --bind lan --port ${PORT:-8080}
