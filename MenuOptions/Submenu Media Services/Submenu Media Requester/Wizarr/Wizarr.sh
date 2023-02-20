#!/bin/bash
######################################################################
# Title   : Install Wizarr
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="Wizarr"                                 # App Name
title="wizarr"                               # Readable App Title
image="ghcr.io/wizarrrr/wizarr"    # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/data/database" # Volumes
porte="5056"                                    # External Port
porti="5055"                                    # Internal Port
extrapayload="    environment:
      - APP_URL=https://wizarr.domain.com
      - DISABLE_BUILTIN_AUTH=false
#     labels:
#   - traefik.enable=true
#   ## HTTP Routers
#   - traefik.http.routers.wizarr-rtr.entrypoints=https
#   - traefik.http.routers.wizarr-rtr.rule=Host(\`wizarr.\${YOURDOMAIN}\`)
#   - traefik.http.routers.wizarr-rtr.tls=true
#   ## HTTP Services
#   - traefik.http.routers.wizarr-rtr.service=wizarr-svc
#   - traefik.http.services.wizarr-svc.loadbalancer.server.port=5690"

# Execute
app