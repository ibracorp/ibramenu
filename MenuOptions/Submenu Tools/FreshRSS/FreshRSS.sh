#!/bin/bash
######################################################################
# Title   : Install Komga
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="FreshRSS"                              # App Name
title="FreshRSS"                            # Readable App Title
image="lscr.io/linuxserver/freshrss:latest" # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
tp_app="Plex"                                   # Theme Park App Name
porte="8040"                                    # External Port
porti="80"                                      # Internal Port
extrapayload=""                                 # Extra Payload to add to the Compose

# Execute
app
