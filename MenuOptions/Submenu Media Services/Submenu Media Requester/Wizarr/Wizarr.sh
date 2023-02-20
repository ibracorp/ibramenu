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
porte="5690"                                    # External Port
porti="5690"                                    # Internal Port
extrapayload="    environment:
      - APP_URL=https://wizarr.\${YOURDOMAIN}
      - DISABLE_BUILTIN_AUTH=false
#     labels:
#       - traefik.enable=true
#       - traefik.http.routers.wizarr.entrypoints=https
#       - traefik.http.routers.wizarr.rule=Host(\`wizarr.\${YOURDOMAIN}\`)"


# Execute
app