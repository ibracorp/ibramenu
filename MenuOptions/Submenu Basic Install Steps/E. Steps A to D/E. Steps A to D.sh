#!/bin/bash

######################################################################
# Title   : Install Steps A to D
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

prepare_full () {
  "../A. Update and Upgrade/A. Update and Upgrade.sh"
  "../B. General Tools/B. General Tools.sh"
  "../C. Install Docker/C. Install Docker.sh"
  "../D. Install Docker Compose/D. Install Docker Compose.sh"
  msgbox "Please remember to reboot if the process did major Upgrades like the Kernel"
}

prepare_full
