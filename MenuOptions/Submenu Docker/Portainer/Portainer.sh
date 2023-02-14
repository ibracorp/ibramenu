#!/bin/bash
######################################################################
# Title   : Install Portainer
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="portainer"                                      # App Name
title="Portainer"                                    # Readable App Title
image="portainer/portainer-ce:latest"                # Image and Tag
volumes="    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./portainer-data:/data"                      # Volumes
tp_app=""                                            # Theme Park App Name
porte="9001"                                         # External Port
porti="9000"                                         # Internal Port
extrapayload=""                                      # Extra Payload to add to the Compose

# Execute
app