#!/bin/bash

######################################################################
# Title   : All Steps
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

all_steps () {
  "../Update and Upgrade/Update and Upgrade.sh"
  "../General Tools/General Tools.sh"
  "../Install Docker/Install Docker.sh"
  "../Install Docker Compose/Install Docker Compose.sh"
  msgbox "Please remember to reboot if the process did major Upgrades like the Kernel"
}

all_steps