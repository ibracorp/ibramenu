#!/bin/bash
######################################################################
# Title   : Install Sonarr
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="sonarr"                               # App Name
title="Sonarr"                             # Readable App Title
image="lscr.io/linuxserver/sonarr:latest"  # Image and Tag
tp_app="sonarr"                            # Theme Park App Name
porte="8989"                               # External Port
porti="8989"                               # Internal Port
extrapayload=""                            # Extra Payload to add to the Compose

# Execute
app