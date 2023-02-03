#!/bin/bash
######################################################################
# Title   : Install AdGuard Home
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="adguardhome"           # App Name
title="AdGuard Home"        # Readable App Title
image="adguard/adguardhome" # Image and Tag

# Disable systemd-resolved
prepare () {
  systemctl disable systemd-resolved.service
  systemctl stop systemd-resolved
}

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
    ports:
      - 53:53/tcp
      - 53:53/udp
      - 784:784/udp
      - 853:853/tcp
      - 3000:3000/tcp
      - 83:80/tcp
    env_file:
      - /opt/appdata/.id.env
      - /opt/appdata/.timezone.env
    volumes:
      - ./work:/opt/adguardhome/work
      - ./conf:/opt/adguardhome/conf
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
  echo "$title: http://$ip:3000"
  echo
}

# Execute

prepare
local_appcreate
local_appfinalization