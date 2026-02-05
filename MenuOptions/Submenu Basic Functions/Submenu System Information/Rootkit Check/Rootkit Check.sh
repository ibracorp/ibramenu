#!/bin/bash
######################################################################
# Title   : Rootkit Check
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

ibralogo
msgbox "Installing/Preparing Rootkit Check"
apt install chkrootkit -y
ibralogo
msgbox "Rootkit Check"
chkrootkit