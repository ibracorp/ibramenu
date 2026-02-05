#!/bin/bash

######################################################################
# Title   : Cloudflare Tunnel Deletion
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# Greetings
greetings () {
  ibralogo
  msgbox "Cloudflare Tunnel Deletion"
}

# Tunnel Deletion
tunneldeletion () {
  cd /opt/appdata/cloudflared
  docker run -it --rm --security-opt apparmor=unconfined -v /opt/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared tunnel delete -f lxc-tunnel
  docker compose down
  id=$(docker image ls -q cloudflare/cloudflared)
  docker image rm $id
  rm *.json
  rm cert.pem
}

# Execute
greetings
tunneldeletion