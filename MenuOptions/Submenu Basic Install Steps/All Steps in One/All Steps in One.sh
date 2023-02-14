#!/bin/bash

######################################################################
# Title   : All Steps
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

all_steps () {
  msgbox "Update and Upgrade - Step 1 of 4"
  "../Update and Upgrade/Update and Upgrade.sh"
  msgbox "General Tools - Step 2 of 4"
  "../General Tools/General Tools.sh"
  msgbox "Docker Install - Step 3 of 4"
  "../Install Docker/Install Docker.sh"
  msgbox "Docker Compose Install - Step 4 of 4"
  "../Install Docker Compose/Install Docker Compose.sh"
  msgbox "Please remember to reboot if the process did major Upgrades like the Kernel"
}

all_steps
