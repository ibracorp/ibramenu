#!/bin/bash
######################################################################
# Title   : Neofetch
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

ibralogo
msgbox "Installing/Preparing Neofetch"
apt install neofetch -y
ibralogo
msgbox "Neofetch"
neofetch