#!/bin/bash

######################################################################
# Title   : Show Video Adapters
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

check_display () {
   sudo lshw -c display
}

check_display
