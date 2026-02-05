#!/bin/bash
######################################################################
# Title   : Install Overseerr
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="overseerr"                                 # App Name
title="Overseerr"                               # Readable App Title
image="lscr.io/linuxserver/overseerr:latest"    # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
porte="5055"                                    # External Port
porti="5055"                                    # Internal Port
extrapayload=""                                 # Extra Payload to add to the Compose

# Execute
app