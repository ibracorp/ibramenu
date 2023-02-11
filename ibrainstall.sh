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
apt install sudo curl git ruby -y
gem install mdless
git clone -b dev --single-branch https://github.com/taos15/ibramenu.git $ifolder
 find $ifolder -type f -iname "*.sh" -exec chmod +x {} \;

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
  insert_alias="alias ibraupdate='sudo /opt/ibracorp/ibramenu/ibraupdate.sh'"
  echo $insert_alias | sudo tee -a /etc/bash.bashrc > /dev/null
  source /etc/bash.bashrc
fi

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh
ibramotd
ibralogo
if [[ -n $1 ]]
then
  if [ $1 = all ]
  then
    cd "/opt/ibracorp/ibramenu/MenuOptions/Submenu Basic Install Steps/All Steps in One"
    "./All Steps in One.sh"
    reboot
  else
    msgbox "Type 'ibramenu' to launch IBRAMENU"
    msgbox "Type 'ibraupdate' to update"
    msgbox "Please reboot after the first installation"
  fi
fi
