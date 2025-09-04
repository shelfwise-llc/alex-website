#!/bin/bash

# Docker deployment script for Alex Website
set -e

# Configuration
APP_NAME="alex_website"
DOCKER_REGISTRY="${DOCKER_REGISTRY:-}"
IMAGE_NAME="${DOCKER_REGISTRY:+$DOCKER_REGISTRY/}$APP_NAME"
IMAGE_TAG="${IMAGE_TAG:-latest}"
ENV_FILE="${ENV_FILE:-.env}"

# Check if .env file exists, create from example if not
if [ ! -f "$ENV_FILE" ]; then
  echo "Creating $ENV_FILE from .env.example..."
  cp .env.example "$ENV_FILE"
  echo "Please update $ENV_FILE with your configuration values."
  exit 1
fi

# Build the Docker image
echo "Building Docker image: $IMAGE_NAME:$IMAGE_TAG"
docker build -t "$IMAGE_NAME:$IMAGE_TAG" .

# Push to registry if specified
if [ -n "$DOCKER_REGISTRY" ]; then
  echo "Pushing image to registry: $IMAGE_NAME:$IMAGE_TAG"
  docker push "$IMAGE_NAME:$IMAGE_TAG"
fi

# Deploy with docker-compose
echo "Deploying with docker-compose..."
docker-compose down --remove-orphans
docker-compose up -d

# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 5

# Check if services are running
echo "Checking service status..."
docker-compose ps

echo "Deployment completed! 🚀"
echo "Your app should be available at: http://localhost:4000"
echo "Ghost CMS is available at: http://localhost:2368"
