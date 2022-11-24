#!/bin/bash

######################################################################
# Title   : IBRAINSTALL Installer and Updater for IBRAMENU
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Check for existing ibramenu folder and clean up if needed
ifolder="/opt/ibracorp/ibramenu"
if [ -d $ifolder ]; then
  rm -r $ifolder
fi
mkdir -p $ifolder

# Clone ibramenu
apt update
apt install git -y
git clone -b main --single-branch https://github.com/ibracorp/ibramenu.git $ifolder
find $ifolder -type f -iname "*.sh" -exec chmod +x {} \;
