#!/bin/bash
######################################################################
# Title   : Install Dashy
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="dashy"                              # App Name
title="Dashy"                            # Readable App Title
image="lissy93/dashy:latest"             # Image and Tag
volumes="    volumes:
      - ./conf.yml:/app/public/conf.yml" # Volumes
porte="8087"                             # External Port
porti="80"                               # Internal Port
extrapayload=""                          # Extra Payload to add to the Compose

# Execute
mkdir -p /opt/appdata/dashy
touch /opt/appdata/dashy/conf.yml
app