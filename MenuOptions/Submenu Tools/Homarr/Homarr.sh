#!/bin/bash
######################################################################
# Title   : Install Homarr
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="homarr"                                          # App Name
title="Homarr"                                        # Readable App Title
image="ghcr.io/ajnart/homarr:latest"                  # Image and Tag
volumes="    volumes:
      - ./homarr/configs:/app/data/configs
      - /var/run/docker.sock:/var/run/docker.sock:ro" # Volumes
porte="7575"                                          # External Port
porti="7575"                                          # Internal Port
extrapayload=""                                       # Extra Payload to add to the Compose

# Execute
app