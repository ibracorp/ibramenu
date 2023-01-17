#!/bin/bash
######################################################################
# Title   : Install Vaultwarden
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="vaultwarden"                 # App Name
title="Vaultwarden"               # Readable App Title
image="vaultwarden/server:latest" # Image and Tag

# App
local_appcreate () {
  msgbox "Installing $title..."
  mkdir -p /opt/appdata/$app && cd /opt/appdata/$app
  tee <<-EOF > .env
APP_NAME=$app
IMAGE=$image
EOF
  tee <<-EOF > compose.yaml
services:
  service-name:
    image: \${IMAGE:?err}
    container_name: \${APP_NAME:?err}
    env_file:
      - /opt/appdata/.id.env
      - /opt/appdata/.timezone.env
    environment:
      WEBSOCKET_ENABLED: "true"  # Enable WebSocket notifications.
      ADMIN_TOKEN: $admintoken
    networks:
      - ibranet
    ports:
      - '8084:80'
    volumes:
      - ./data:/data
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined
networks:
  ibranet:
    driver: bridge
    external: true
EOF
  docker compose up -d --force-recreate
}

# List Links
local_appfinalization () {
  ibralogo
  msgbox "All Done! Here is the link to $title:"
  echo
  ip=$(hostname -I | awk '{print $1}')
  echo "$title: http://$ip:8084/admin"
  echo
  echo "Your Admin Token is: $admintoken"
  echo "Keep this token secret! This is the password to access the admin area of your server!"
  echo
}

# Execute

# Generate Admin Token
admintoken=$(openssl rand -base64 48)

local_appcreate
local_appfinalization