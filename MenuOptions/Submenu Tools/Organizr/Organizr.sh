#!/bin/bash
######################################################################
# Title   : Install Organizr
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="organizr"                                          # App Name
title="Organizr"                                        # Readable App Title
image="ghcr.io/organizr/organizr"                  # Image and Tag
volumes="    volumes:
      - /opt/appdata/organizr:/config" # Volumes
porte="8082"                                          # External Port
porti="80"                                          # Internal Port
extrapayload=""                                       # Extra Payload to add to the Compose

# Execute
app