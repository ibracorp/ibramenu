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
apt install sudo curl git -y
git clone -b main --single-branch https://github.com/ibracorp/ibramenu.git $ifolder
find $ifolder -type f -iname "*.sh" -exec chmod +x {} \;
cp /opt/ibracorp/ibramenu/ibrainstall.sh /opt/ibracorp/ibrainstall.sh

# Add ibramenu as systemwide alias
if ! grep -q ibramenu /etc/bash.bashrc
then
  insert_alias="alias ibramenu='sudo /opt/ibracorp/ibramenu/ibramenu.sh'"
  echo $insert_alias | sudo tee -a /etc/bash.bashrc > /dev/null
  source /etc/bash.bashrc
fi
# Add ibraupdate as systemwide alias
if ! grep -q ibraupdate /etc/bash.bashrc
then
  insert_alias="alias ibraupdate='sudo /opt/ibracorp/ibrainstall.sh'"
  echo $insert_alias | sudo tee -a /etc/bash.bashrc > /dev/null
  source /etc/bash.bashrc
fi

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh
ibramotd
ibralogo
msgbox "Type 'ibramenu' to launch IBRAMENU"
msgbox "Type 'ibraupdate' to update"
msgbox "Please reboot after the first installation"
