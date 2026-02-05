#!/bin/bash
######################################################################
# Title   : Install Minecraft Direwolf20 1.19
# By      : Sycotix, DiscDuck, Taos15
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

ibralogo
msgbox "Installing Minecraft FTB Direwolf20 1.19"

mkdir -p /opt/appdata/minecraft/direwolf20-1.19
cd /opt/appdata/minecraft/direwolf20-1.19
wget https://api.modpacks.ch/public/modpack/101/2296/server/linux
chmod +x linux
echo "eula=true" > eula.txt
./linux 101 --auto

msgbox "Minecraft Direwolf20 1.19 installed"