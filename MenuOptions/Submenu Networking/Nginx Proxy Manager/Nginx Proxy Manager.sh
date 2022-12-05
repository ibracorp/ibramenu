#!/bin/bash
######################################################################
# Title   : Install Nginx Proxy Manager
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="npm"                               # App Name
title="Nginx Proxy Manager"             # Readable App Title
image="jc21/nginx-proxy-manager:latest" # Image and Tag

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
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    networks:
      - ibranet
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
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
  echo "$title: http://$ip:81"
  echo
  echo "Default Admin User"
  echo "Email   : admin@example.com"
  echo "Password: changeme"
  echo
}

# Execute

local_appcreate
local_appfinalization