#!/bin/bash
######################################################################
# Title   : Install Komga
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="Plex-Meta-Manager"              # App Name
title="Plex-Meta-Manager"            # Readable App Title
image="meisnate12/plex-meta-manager" # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
tp_app="Plex"                                   # Theme Park App Name
# porte="8085"                                    # External Port
# porti="8080"                                    # Internal Port
extrapayload="" # Extra Payload to add to the Compose

# Execute
app

sudo mkdir -p /opt/appdata/Plex-Meta-Manager/assets
curl -fLvo /opt/appdata/Plex-Meta-Manager/config.yml https://raw.githubusercontent.com/meisnate12/Plex-Meta-Manager/master/config/config.yml.template
