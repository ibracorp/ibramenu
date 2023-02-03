#!/bin/bash
######################################################################
# Title   : Reboot
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

ibralogo
msgbox "System Reboot"
read -p "Are you sure? " -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
    reboot
fi
