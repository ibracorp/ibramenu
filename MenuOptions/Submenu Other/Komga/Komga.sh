#!/bin/bash
######################################################################
# Title   : Install Komga
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="Komga"                                  # App Name
title="Komga"                                # Readable App Title
image="lscr.io/linuxserver/Komga:latest"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
tp_app="Komga"                               # Theme Park App Name
porte="8085"                                    # External Port
porti="8080"                                    # Internal Port
extrapayload=""                                 # Extra Payload to add to the Compose


# Execute
app