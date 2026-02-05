#!/bin/bash

######################################################################
# Title   : Update and Upgrade
# By      : Sycotix, DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

update_upgrade () {
   sudo apt update
   sudo apt upgrade -y
   msgbox "Please remember to reboot if the process did major Upgrades like the Kernel"
}

update_upgrade
