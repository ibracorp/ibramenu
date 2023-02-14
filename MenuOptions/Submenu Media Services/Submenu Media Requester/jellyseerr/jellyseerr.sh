#!/bin/bash
######################################################################
# Title   : Install Overseerr
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="jellyseerr"                                 # App Name
title="jellyseerr"                               # Readable App Title
image="fallenbagel/jellyseerr:latest"    # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/app/config" # Volumes
porte="5055"                                    # External Port
porti="5055"                                    # Internal Port
extrapayload="    environment:
            - JELLYFIN_TYPE=emby"     #comment if using jellyfin                            # Extra Payload to add to the Compose

# Execute
app