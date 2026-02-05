#!/bin/bash
######################################################################
# Title   : Power Down
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

ibralogo
msgbox "System Power Down"
read -p "Are you sure (y/N)? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    /sbin/shutdown -h now
fi
