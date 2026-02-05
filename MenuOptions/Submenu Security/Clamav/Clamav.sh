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
app="Clamav"                                  # App Name
title="Clamav"                                # Readable App Title
image="clamav/clamav"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
tp_app="Clamav"                               # Theme Park App Name
porte="3310"                                    # External Port
porti="3310"                                    # Internal Port
extrapayload=""                                 # Extra Payload to add to the Compose


# Execute
app