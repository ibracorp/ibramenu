#!/bin/bash
######################################################################
# Title   : Install SABnzbd
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="qbittorrent"                                  # App Name
title="qbittorrent"                                # Readable App Title
image="lscr.io/linuxserver/qbittorrent:latest"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config
      - /mnt/media:/media"                     # Volumes
tp_app="qbittorrent"                                # Theme Park App Name
porte=""                                   # External Port
porti=""                                   # Internal Port
extrapayload="    ports:
      - 8081:8080
      - 6881:6881
      - 6881:6881/udp"                                # Extra Payload to add to the Compose

# Execute
app