#!/bin/bash
######################################################################
# Title   : Display Memory Information
# By      : DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

ibralogo
msgbox "Memory Information"
free -h
read -p "Press Enter to continue..."
dmidecode -t memory