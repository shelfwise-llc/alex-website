#!/bin/bash

# Build script for Docker deployment
set -e

echo "Building assets with Bun..."
cd assets
bun install --frozen-lockfile
bun run css:deploy
bun run deploy
cd ..

echo "Digesting assets..."
mix phx.digest

echo "Building Docker image..."
docker build -t alex-website .

echo "Build complete! 🎉"
