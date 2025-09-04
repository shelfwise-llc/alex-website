# Build assets using Bun
FROM oven/bun:latest AS assets

WORKDIR /app/assets

# Copy asset files
COPY assets/package.json assets/bun.lock* ./
RUN bun install --frozen-lockfile

# Copy all asset source files
COPY assets .

# Build assets for production
RUN bun run css:deploy && bun run deploy

# Build stage for Phoenix
FROM elixir:1.14-alpine AS builder

# Install build dependencies
RUN apk add --no-cache build-base npm git python3

# Set build ENV
ENV MIX_ENV=prod

# Install mix dependencies
RUN mix local.hex --force && mix local.rebar --force

WORKDIR /app

# Copy mix files
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

# Copy source code
COPY lib lib
COPY priv priv
COPY config config

# Copy built assets from assets stage
COPY --from=assets /app/assets/../priv/static ./priv/static

# Compile the release
RUN mix compile
RUN mix phx.digest

# Build the release
RUN mix release

# Runtime stage
FROM alpine:3.18 AS runtime

# Install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ncurses-libs

# Create user
RUN adduser -D -s /bin/sh phoenix
USER phoenix

WORKDIR /app

# Copy the release from builder stage
COPY --from=builder --chown=phoenix:phoenix /app/_build/prod/rel/alex_website ./

# Set environment variables
ENV HOME=/app
ENV MIX_ENV=prod
# SECRET_KEY_BASE will be provided at runtime via environment variables
ENV PHX_HOST=localhost
ENV PORT=4000

EXPOSE 4000

# Start the Phoenix app
CMD ["/app/bin/alex_website", "start"]
