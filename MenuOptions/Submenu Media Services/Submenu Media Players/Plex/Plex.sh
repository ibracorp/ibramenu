#!/bin/bash
######################################################################
# Title   : Install Plex
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="plex"                              # App Name
title="Plex"                            # Readable App Title
image="lscr.io/linuxserver/plex:latest" # Image and Tag
tp_app="plex"                           # Theme Park App Name


# App
local_appcreate () {
  msgbox "Installing $title..."
  mkdir -p /opt/appdata/$app && cd /opt/appdata/$app
  tee <<-EOF > .env
APP_NAME=$app
IMAGE=$image
TP_APP=$tp_app
EOF
  tee <<-EOF > compose.yaml
services:
  service-name:
    image: \${IMAGE:?err}
    container_name: \${APP_NAME:?err}
    network_mode: host
    env_file:
      - /opt/appdata/.id.env
      - /opt/appdata/.timezone.env
      - /opt/appdata/.themepark.env
    environment:
      - VERSION=docker
      - PLEX_PASS="yes"
      - PLEX_CLAIM= #optional
      - ADVERTISE_IP
      - ALLOWED_NETWORKS
    volumes:
      - /opt/appdata/plex/config:/config
      - /opt/appdata/plex/transcode:/transcode
      - /mnt/media:/media      
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined
EOF
  docker compose up -d --force-recreate
}

# List Links
local_appfinalization () {
  ibralogo
  msgbox "All Done! Here is the link to $title:"
  echo
  ip=$(hostname -I | awk '{print $1}')
  echo "$title: http://$ip:32400/web"
  echo
}

# Execute

local_appcreate
local_appfinalization