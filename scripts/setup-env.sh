#!/bin/bash

# Setup environment script for Docker deployment
set -e

# Create .env file from example if it doesn't exist
if [ ! -f .env ]; then
  echo "Creating .env file from template..."
  cat > .env << EOF
# Database Configuration
DATABASE_URL=ecto://postgres:postgres@db/alex_website_prod
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=alex_website_prod

# Phoenix Configuration
SECRET_KEY_BASE=$(mix phx.gen.secret)
PHX_HOST=localhost
PORT=4000

# Ghost CMS Configuration
GHOST_CONTENT_API_KEY=your-ghost-api-key
GHOST_ADMIN_API_KEY=your-ghost-admin-api-key
GHOST_URL=http://ghost:2368

# Ghost Database Configuration
GHOST_DB_PASSWORD=your-secret-password
EOF
  echo ".env file created successfully!"
else
  echo ".env file already exists. Skipping creation."
fi

# Make sure .env is in .gitignore
if ! grep -q "^.env$" .gitignore; then
  echo "Adding .env to .gitignore..."
  echo ".env" >> .gitignore
  echo "Added .env to .gitignore"
fi

echo "Environment setup complete! 🎉"
