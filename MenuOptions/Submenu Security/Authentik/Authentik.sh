#!/bin/bash
######################################################################
# Title   : Install Authentik
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="authentik"   # App Name
title="Authentik" # Readable App Title

# Parameters
parameters () {
  msgbox "Setting Parameters for Your Setup"
  tee <<-EOF
We will now automatically install your Authentik Solution.
You will be asked the following questions:
Your Domain like "yourdomain.com"
Please enter all parameters without any "".
EOF
  read -p "Your Domain        : " domain
}

# Authentik Environment
authentik_env () {
  msgbox "Generating secure Passwords and setting up Environment..."
  mkdir -p /opt/appdata/authentik && cd /opt/appdata/authentik
  msgbox "Making backups of .env and compose.yaml (if exist)"
  if [ -f ".env" ]
  then
    mv .env .env.bak
  fi
  if [ -f "compose.yaml" ]
  then
    mv compose.yaml compose.yaml.bak
  fi
  apt-get install -y pwgen
  echo "PG_PASS=$(pwgen -s 40 1)" >> .env
  echo "AUTHENTIK_SECRET_KEY=$(pwgen -s 50 1)" >> .env
  echo "AUTHENTIK_ERROR_REPORTING__ENABLED=true" >> .env
  echo AUTHENTIK_PORT_HTTP=9000 >> .env
  echo AUTHENTIK_PORT_HTTPS=9443 >> .env
}

# App
local_appcreate () {
  msgbox "Installing $title..."
  tee <<-EOF > compose.yaml
services:
  postgresql:
    image: postgres:12-alpine
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined
    container_name: authentik-postgres
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -d \$\${POSTGRES_DB} -U \$\${POSTGRES_USER}"]
      start_period: 20s
      interval: 30s
      retries: 5
      timeout: 5s
    volumes:
      - database:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=\${PG_PASS}
      - POSTGRES_USER=\${PG_USER:-authentik}
      - POSTGRES_DB=\${PG_DB:-authentik}
    env_file:
      - .env
    networks:
      - $dockernet
  redis:
    image: redis:alpine
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined
    container_name: authentik-redis
    healthcheck:
      test: ["CMD-SHELL", "redis-cli ping | grep PONG"]
      start_period: 20s
      interval: 30s
      retries: 5
      timeout: 3s
    networks:
      - $dockernet
  server:
    image: \${AUTHENTIK_IMAGE:-ghcr.io/goauthentik/server}:\${AUTHENTIK_TAG:-2022.7.2}
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined
    container_name: authentik-server
    command: server
    environment:
      AUTHENTIK_REDIS__HOST: authentik-redis
      AUTHENTIK_POSTGRESQL__HOST: authentik-postgres
      AUTHENTIK_POSTGRESQL__USER: \${PG_USER:-authentik}
      AUTHENTIK_POSTGRESQL__NAME: \${PG_DB:-authentik}
      AUTHENTIK_POSTGRESQL__PASSWORD: \${PG_PASS}
    volumes:
      - ./media:/media
      - ./custom-templates:/templates
      - geoip:/geoip
    env_file:
      - .env
    ports:
      - "0.0.0.0:${AUTHENTIK_PORT_HTTP:-9000}:9000"
      - "0.0.0.0:${AUTHENTIK_PORT_HTTPS:-9443}:9443"
    networks:
      - $dockernet
    labels:
      traefik.enable: true
      traefik.http.routers.authentik.entryPoints: https
      traefik.http.routers.authentik.rule: Host(\`auth.$domain\`) || HostRegexp(\`{subdomain:[a-z0-9]+}.$domain\`) && PathPrefix(\`/outpost.goauthentik.io/\`)
  worker:
    image: \${AUTHENTIK_IMAGE:-ghcr.io/goauthentik/server}:\${AUTHENTIK_TAG:-2022.7.2}
    restart: unless-stopped
    security_opt:
      - apparmor:unconfined
    container_name: authentik-worker
    command: worker
    environment:
      AUTHENTIK_REDIS__HOST: authentik-redis
      AUTHENTIK_POSTGRESQL__HOST: authentik-postgres
      AUTHENTIK_POSTGRESQL__USER: \${PG_USER:-authentik}
      AUTHENTIK_POSTGRESQL__NAME: \${PG_DB:-authentik}
      AUTHENTIK_POSTGRESQL__PASSWORD: \${PG_PASS}
    user: root
    volumes:
      - ./media:/media
      - ./certs:/certs
      - /var/run/docker.sock:/var/run/docker.sock
      - ./custom-templates:/templates
      - geoip:/geoip
    env_file:
      - .env
    networks:
      - $dockernet
#  geoipupdate:
#    image: "maxmindinc/geoipupdate:latest"
#    container_name: authentik-geoip
#    security_opt:
#      - apparmor:unconfined
#    volumes:
#      - "geoip:/usr/share/GeoIP"
#    environment:
#      GEOIPUPDATE_EDITION_IDS: "GeoLite2-City"
#      GEOIPUPDATE_FREQUENCY: "8"
#    env_file:
#      - .env
#    networks:
#      - $dockernet
volumes:
  database:
    driver: local
  geoip:
    driver: local
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
  echo "Authentik: http://$ip:9000/if/flow/initial-setup/"
  echo "It will take a few seconds for the database to initialize and all containers to run..."
  echo
}

# Execute

parameters
authentik_env
local_appcreate
local_appfinalization