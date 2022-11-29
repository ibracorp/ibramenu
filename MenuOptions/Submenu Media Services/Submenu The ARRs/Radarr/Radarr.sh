#!/bin/bash
######################################################################
# Title   : Install Radarr
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# App Info
app="radarr"                               # App Name
title="Radarr"                             # Readable App Title
image="lscr.io/linuxserver/radarr:latest"  # Image and Tag
tp_app="radarr"                            # Theme Park App Name
porte="7878"                               # External Port
porti="7878"                               # Internal Port
extrapayload=""                            # Extra Payload to add to the Compose

# Execute
app