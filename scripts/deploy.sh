#!/bin/bash

# Configuration
APP_NAME="alex_website"
DEPLOY_USER="${DEPLOY_USER:-deploy}"
DEPLOY_HOST="${DEPLOY_HOST:-localhost}"
DEPLOY_TO="/home/$DEPLOY_USER/apps/$APP_NAME"
DEPLOY_IP="${DEPLOY_IP:-localhost}"
CURRENT_ENV="${MIX_ENV:-prod}"

# Create release
echo "Building release..."
mix deps.get --only $CURRENT_ENV
mix compile
mix assets.deploy
mix phx.digest
mix release --overwrite

# Ensure deploy directory exists
ssh $DEPLOY_USER@$DEPLOY_HOST "mkdir -p $DEPLOY_TO/releases"

# Copy release
echo "Copying release..."
scp _build/$CURRENT_ENV/rel/$APP_NAME/releases/*/alex_website.tar.gz $DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_TO/releases/

# Deploy
echo "Deploying..."
ssh $DEPLOY_USER@$DEPLOY_HOST bash -c "cd $DEPLOY_TO && \
  tar xzf releases/alex_website.tar.gz && \
  ./bin/alex_website daemon_iex"

# Configure Nginx
echo "Configuring Nginx..."
cat > /tmp/alex_website.nginx.conf << EOF
server {
    server_name alex-website-${CURRENT_ENV}.${DEPLOY_IP}.nip.io;
    
    location / {
        proxy_pass http://localhost:4000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
    }
}
EOF

# Copy and activate Nginx config
scp /tmp/alex_website.nginx.conf $DEPLOY_USER@$DEPLOY_HOST:/etc/nginx/sites-available/alex_website
ssh $DEPLOY_USER@$DEPLOY_HOST "ln -sf /etc/nginx/sites-available/alex_website /etc/nginx/sites-enabled/ && \
  sudo nginx -t && \
  sudo systemctl reload nginx"

echo "Deployment completed! Your app should be available at:"
echo "http://alex-website-${CURRENT_ENV}.${DEPLOY_IP}.nip.io"
