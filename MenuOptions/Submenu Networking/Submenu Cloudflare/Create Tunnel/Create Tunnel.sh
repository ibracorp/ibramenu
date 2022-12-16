#!/bin/bash

######################################################################
# Title   : Cloudflare Tunnel Installer
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# Greetings
greetings () {
  ibralogo
  msgbox "Cloudflare Tunnel Installer"
}

# Parameters
parameters () {
  msgbox "Setting Parameters for Your Setup"
  tee <<-EOF
We will now automatically install your Cloudflare Tunnel.

Please enter all parameters without any "".

EOF
  read -p "Your Domain (domain.com)            : " domain
  read -p "The IP address of your Reverse Proxy: " ip
  read -p "The port of your Reverse Proxy      : " port
  read -p "The tunnel name (lower caps)        : " tunnel
  echo
  }

# Preparations
preparations () {
  mkdir -p /opt/appdata/cloudflared
  chmod -R 777 /opt/appdata/cloudflared
  cd /opt/appdata/cloudflared
}

# Tunnel Creation
tunnelcreation () {
  msgbox "Tunnel Authentication"
  echo
  echo "Please follow the Cloudflare link and authorize the correct Domain"
  echo

  docker run -it --rm --security-opt apparmor=unconfined -v /opt/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared tunnel login

  docker run -it --rm --security-opt apparmor=unconfined -v /opt/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared tunnel create $tunnel

  jid=$(basename *.json .json)

  tee <<-EOF > compose.yaml
services:
  cloudflared:
    image: cloudflare/cloudflared
    container_name: cloudflared
    restart: unless-stopped
    command: tunnel --config /home/nonroot/.cloudflared/config.yml run $jid
    volumes:
      - /opt/appdata/cloudflared:/home/nonroot/.cloudflared/
    security_opt:
      - apparmor:unconfined
EOF
  tee <<-EOF > config.yml
tunnel: $jid
credentials-file: /home/nonroot/.cloudflared/$jid.json

ingress:
  - service: https://$ip:$port
    originRequest:
      originServerName: $domain
EOF

  docker compose up -d --force-recreate
}

# Execute
greetings
parameters
preparations
tunnelcreation
