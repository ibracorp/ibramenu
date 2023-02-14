#!/bin/bash
######################################################################
# Title   : Install Tautulli
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="tautulli"                                  # App Name
title="Tautulli"                                # Readable App Title
image="lscr.io/linuxserver/tautulli:latest"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
tp_app="tautulli"                               # Theme Park App Name
porte="8181"                                    # External Port
porti="8181"                                    # Internal Port
extrapayload=""                                 # Extra Payload to add to the Compose

# Execute
app