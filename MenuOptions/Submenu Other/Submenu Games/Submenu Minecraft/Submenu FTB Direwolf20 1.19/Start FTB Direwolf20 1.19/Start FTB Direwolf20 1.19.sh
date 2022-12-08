#!/bin/bash
######################################################################
# Title   : Install Minecraft Direwolf20 1.19
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

ibralogo

if [ -f "/opt/appdata/minecraft/direwolf20-1.19/start.sh" ]
then
  msgbox "Starting Minecraft Direwolf20 1.19"
  cd /opt/appdata/minecraft/direwolf20-1.19
  ./start.sh
else
  msgbox "Minecraft Direwolf20 1.19 is missing, please install"
fi