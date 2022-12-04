#!/bin/bash

######################################################################
# Title   : Install Watchtower on schedule
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP   ^d
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="watchtower"              # App Name
title="Watchtower"            # Readable App Title
image="containrrr/watchtower" # Image and Tag

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
      - /opt/appdata/.timezone.env
    environment:
      - WATCHTOWER_CLEANUP=true
      - WATCHTOWER_INCLUDE_RESTARTING=true
      - WATCHTOWER_INCLUDE_STOPPED=true
      - WATCHTOWER_SCHEDULE=0 0 3 * * *
      - WATCHTOWER_TIMEOUT=30  
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined
EOF
  docker compose up -d --force-recreate
}

# List Links
local_appfinalization () {
  ibralogo
  msgbox "All Done! Watchtower will run every morning at 3am"
  echo
}

# Execute

local_appcreate
local_appfinalization