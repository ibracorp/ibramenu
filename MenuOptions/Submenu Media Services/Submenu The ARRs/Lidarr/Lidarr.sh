#!/bin/bash
######################################################################
# Title   : Install Lidarr
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="lidarr"                                   # App Name
title="Lidarr"                                 # Readable App Title
image="lscr.io/linuxserver/lidarr:latest"      # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config
      - /mnt/media:/media"                     # Volumes
tp_app="lidarr"                                # Theme Park App Name
porte="8686"                                   # External Port
porti="8686"                                   # Internal Port
extrapayload=""                                # Extra Payload to add to the Compose

# Execute
app