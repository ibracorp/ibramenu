#!/bin/bash
set -euo pipefail

######################################################################
# Title   : Beachhead - Initial Installer for IBRAMENU
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

ifolder="/opt/ibracorp/ibramenu"
if ! command -v mdless >/dev/null 2>&1; then
  apt update
  apt install -y ruby
  gem install mdless
fi
sudo bash -c "rm -rf \"$ifolder\""
sudo bash -c "git clone -b main --single-branch https://github.com/ibracorp/ibramenu.git \"$ifolder\""
sudo find "$ifolder" -type f -iname "*.sh" -exec chmod +x {} \;

# update the custom docker netwrok use in all the containers
update_docker_network() {
  read -r -p "Enter the name of your custom docker network (ex. ibranet) : " customnetwork
  sed -i "s/^dockernet=.*$/dockernet=$customnetwork/" /opt/ibracorp/ibramenu/.profile
  docker network create "$customnetwork" >/dev/null 2>&1
}

update_docker_network
# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh
