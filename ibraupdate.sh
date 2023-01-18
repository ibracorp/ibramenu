#!/bin/bash

######################################################################
# Title   : Beachhead - Initial Installer for IBRAMENU
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

sudo bash -c "rm -R /opt/ibracorp/ibramenu/"
sudo bash -c "git clone -b komf --single-branch https://github.com/taos15/ibramenu.git /opt/ibracorp/ibramenu"
find $ifolder -type f -iname "*.sh" -exec chmod +x {} \;

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh