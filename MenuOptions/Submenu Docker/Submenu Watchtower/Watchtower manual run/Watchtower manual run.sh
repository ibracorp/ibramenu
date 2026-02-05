#!/bin/bash

######################################################################
# Title   : Watchtower manual run
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# Greetings
greetings () {
  ibralogo
  msgbox "Watchtower manual run"
}

# Check for Updates and Update Container

update_container () {
  ibralogo
  echo
  echo "Watchtower will check for Updates and update your Containers if needed..."
  echo
  docker run --rm --security-opt apparmor=unconfined -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --run-once
  echo
  msgbox "All done!"
  echo
}

# Execute
greetings
update_container