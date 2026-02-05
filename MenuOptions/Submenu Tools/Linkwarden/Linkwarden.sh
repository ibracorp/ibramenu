#!/bin/bash
######################################################################
# Title   : Install Linkwarden
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

read -p "Enter postgres password            : " YOUR_POSTGRES_PASSWORD
read -p "Enter NEXTAUTH secret              : " VERY_SENSITIVE_SECRET
sudo mkdir -p /opt/appdata/Linkwarden

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh
# source /opt/ibracorp/ibramenu/MenuOptions/Submenu Networking/Dockerproxy/Dockerproxy.sh
# Linkwarden config

# App Info
app="Linkwarden"                             # App Name
title="linkwarden"                           # Readable App Title
image="ghcr.io/linkwarden/linkwarden:latest" # Image and Tag
volumes="    volumes:
      - ./data:/data/data" # Volumes
tp_app=""                  # Theme Park App Name
porte="8099"               # External Port
porti="3000"
extrapayload="    environment:
      - DATABASE_URL=postgresql://postgres:\${POSTGRES_PASSWORD}@postgres:5432/postgres

    " # Extra Payload to add to the Compose add 4 spance to the top group for example environment: and 6 for the childs (if copy and pasting you just need to add the space to the parent).

appcreate_local() {
    msgbox "Installing $title..."
    mkdir -p /opt/appdata/$app && cd /opt/appdata/$app
    rm compose.yaml
    tee <<-EOF >.env
APP_NAME=$app
IMAGE=$image
TP_APP=$tp_app
PORTE=$porte
PORTI=$porti
NEXTAUTH_URL=http://localhost:3000
POSTGRES_PASSWORD=$YOUR_POSTGRES_PASSWORD
NEXTAUTH_SECRET=${VERY_SENSITIVE_SECRET}
EOF
    tee <<-EOF >compose.yaml
services:
  postgres:
    image: postgres
    env_file: .env
    restart: always
    volumes:
      - ./pgdata:/var/lib/postgresql/data
  linkwarden:
    image: \${IMAGE:?err}
    depends_on:
      - postgres
    env_file:
      - /opt/appdata/$app/.env
      - /opt/appdata/.id.env
      - /opt/appdata/.timezone.env
EOF
    if [ ! -z "$tp_app" ]; then
        echo "      - /opt/appdata/.themepark.env" >>compose.yaml
    fi
    if [ ! -z "$volumes" ]; then
        echo "$volumes" >>compose.yaml
    fi
    if [ ! -z "$porti" ]; then
        tee <<-EOF >>compose.yaml
    ports:
      - \${PORTE:?err}:\${PORTI:?err}
EOF
    fi

    tee <<-EOF >>compose.yaml
    networks:
      - $dockernet
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined
$extrapayload
networks:
  $dockernet:
    driver: bridge
    external: true
EOF
  docker compose up -d --force-recreate
}

# Execute
appcreate_local
sleep 2

# # Create the config files
