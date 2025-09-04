#!/bin/bash

# Test deployment script with nip.io domain
set -e

# Create Traefik directory if it doesn't exist
mkdir -p traefik

# Create Traefik dynamic config
cat > traefik/traefik.yml << EOF
api:
  dashboard: true
  insecure: true

entryPoints:
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https
  websecure:
    address: ":443"

certificatesResolvers:
  letsencrypt:
    acme:
      email: your-email@example.com
      storage: /etc/traefik/acme.json
      httpChallenge:
        entryPoint: web

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
EOF

# Create empty ACME JSON file with correct permissions
touch traefik/acme.json
chmod 600 traefik/acme.json

# Build and deploy
echo "Building and deploying with nip.io domain..."
docker-compose -f docker-compose.test.yml down --remove-orphans
docker-compose -f docker-compose.test.yml build
docker-compose -f docker-compose.test.yml up -d

echo "Deployment completed! 🚀"
echo "Your app should be available at: https://alex.38.242.219.222.nip.io"
echo "Ghost CMS is available at: https://ghost.alex.38.242.219.222.nip.io"




