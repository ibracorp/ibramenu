#!/bin/bash
######################################################################
# Title   : Install Sonarr 4K
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="sonarr4k"                                 # App Name
title="Sonarr 4K"                              # Readable App Title
image="lscr.io/linuxserver/sonarr:latest"      # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config
      - /mnt/media:/media"                     # Volumes
tp_app="sonarr"                                # Theme Park App Name
porte="8990"                                   # External Port
porti="8989"                                   # Internal Port
extrapayload="    environment:
      - TP_ADDON=sonarr-4k-logo"               # Extra Payload to add to the Compose

# Execute
app