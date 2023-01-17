#!/bin/bash
######################################################################
# Title   : Install Ombi
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="ombi"                                      # App Name
title="Ombi"                                    # Readable App Title
image="lscr.io/linuxserver/ombi:latest"         # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
porte="3579"                                    # External Port
porti="3579"                                    # Internal Port
extrapayload=""                                 # Extra Payload to add to the Compose

# Execute
app