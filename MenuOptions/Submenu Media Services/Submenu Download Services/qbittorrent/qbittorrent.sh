#!/bin/bash
######################################################################
# Title   : Install SABnzbd
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="qbittorrent"                                  # App Name
title="qbittorrent"                                # Readable App Title
image="cr.hotio.dev/hotio/qbittorrent"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config
      - /mnt/media:/media"                     # Volumes
tp_app="qbittorrent"                                # Theme Park App Name
porte="8080"                                   # External Port
porti="8080"                                   # Internal Port
extrapayload=""                                # Extra Payload to add to the Compose

# Execute
app