#!/bin/bash
######################################################################
# Title   : List all Docker Container
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

ibralogo
msgbox "List of all Docker Container"

docker container ls --format "table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.Size}}\t{{.Networks}}"