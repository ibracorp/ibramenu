#!/bin/bash
######################################################################
# Title   : Install Uptime Kuma
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="uptime-kuma"                     # App Name
title="Uptime Kuma"                   # Readable App Title
image="louislam/uptime-kuma:1"        # Image and Tag
volumes="    volumes:
      - ./uptime-kuma-data:/app/data" # Volumes
porte="3001"                          # External Port
porti="3001"                          # Internal Port
extrapayload=""                       # Extra Payload to add to the Compose

# Execute
app