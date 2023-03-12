#!/bin/bash

######################################################################
# Title   : Beachhead - Initial Installer for IBRAMENU
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

sudo bash -c "rm -R /opt/ibracorp/ibramenu/"
sudo bash -c "git clone -b dev --single-branch https://github.com/ibracorp/ibramenu.git /opt/ibracorp/ibramenu"
sudo find $ifolder -type f -iname "*.sh" -exec chmod +x {} \;

# update the custom docker netwrok use in all the containers
update_docker_network() {
  read -p "Enter the name of your custome docker network (ex. ibranet) : " customnetwork
  sed -i "s/^dockernet=.*$/dockernet=$customnetwork/" /opt/ibracorp/ibramenu/.profile
  docker network create $customnetwork >/dev/null 2>&1
}

update_docker_network
# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh
