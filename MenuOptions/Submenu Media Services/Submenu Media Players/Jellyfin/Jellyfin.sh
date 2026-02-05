#!/bin/bash
######################################################################
# Title   : Install Jellyfin
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="jellyfin"                              # App Name
title="Jellyfin"                            # Readable App Title
image="lscr.io/linuxserver/jellyfin:latest" # Image and Tag

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
    env_file:
      - /opt/appdata/.id.env
      - /opt/appdata/.timezone.env
#    environment:
#      - JELLYFIN_PublishedServerUrl=192.168.0.5 #optional
    volumes:
      - /opt/appdata/jellyfin/config:/config
      - /mnt/media:/media
    ports:
      - 8096:8096
#      - 8920:8920 #optional
#      - 7359:7359/udp #optional
#      - 1900:1900/udp #optional
    networks:
      - $dockernet
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined

networks:
  $dockernet:
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
  echo "$title: http://$ip:8096"
  echo
}

# Execute

local_appcreate
local_appfinalization