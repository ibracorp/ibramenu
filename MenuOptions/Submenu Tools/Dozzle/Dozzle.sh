#!/bin/bash
######################################################################
# Title   : Install Dozzle
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="dozzle"                                       # App Name
title="Dozzle"                                     # Readable App Title
image="amir20/dozzle:latest"                       # Image and Tag
volumes="    volumes:
      - /var/run/docker.sock:/var/run/docker.sock" # Volumes
porte="9999"                                       # External Port
porti="8080"                                       # Internal Port
extrapayload=""                                    # Extra Payload to add to the Compose

# Execute
app