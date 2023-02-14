#!/bin/bash
######################################################################
# Title   : Install Prowlarr
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="prowlarr"                                   # App Name
title="Prowlarr"                                 # Readable App Title
image="lscr.io/linuxserver/prowlarr:develop"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
tp_app="prowlarr"                                 # Theme Park App Name
porte="9696"                                    # External Port
porti="9696"                                    # Internal Port
extrapayload=""                                 # Extra Payload to add to the Compose

# Execute
app