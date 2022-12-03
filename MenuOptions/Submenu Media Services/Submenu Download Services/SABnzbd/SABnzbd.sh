#!/bin/bash
######################################################################
# Title   : Install SABnzbd
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="sabnzbd"                                  # App Name
title="SABnzbd"                                # Readable App Title
image="lscr.io/linuxserver/sabnzbd:latest"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config
      - /mnt/media:/media"                     # Volumes
tp_app="sabnzbd"                                # Theme Park App Name
porte="8081"                                   # External Port
porti="8080"                                   # Internal Port
extrapayload=""                                # Extra Payload to add to the Compose

# Execute
app