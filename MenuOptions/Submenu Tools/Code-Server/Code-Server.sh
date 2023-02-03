#!/bin/bash
######################################################################
# Title   : Install Code-Server
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="code-server"                               # App Name
title="Code Server"                             # Readable App Title
image="lscr.io/linuxserver/code-server:latest"  # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config
      - /opt:/opt"                              # Volumes
tp_app=""                                       # Theme Park App Name
porte="8443"                                    # External Port
porti="8443"                                    # Internal Port
extrapayload="    environment:
      - PUID=0
      - PGID=0"                                 # Extra Payload to add to the Compose

# Execute
app
