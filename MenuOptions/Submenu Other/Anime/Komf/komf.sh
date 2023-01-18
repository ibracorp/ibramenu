#!/bin/bash
######################################################################
# Title   : Install Komga
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# Collect komga login email and password
read -p "Your login email            : " email
read -p "Please enter komga password     : " passwd
echo "KOMF_KOMGA_USER=$email" >> .env
echo "KOMF_KOMGA_PASSWORD=$passwd" >> .env

# App Info
app="komf"                                  # App Name
title="komf"                                # Readable App Title
image="sndxr/komf:latest"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/config" # Volumes
tp_app=""                               # Theme Park App Name
porte="8089"                                    # External Port
porti="8085"                                    # Internal Port
extrapayload="    environment: # optional env config
      - KOMF_KOMGA_BASE_URI=http://komga
      - KOMF_KOMGA_USER=$email
      - KOMF_KOMGA_PASSWORD=$passwd
      - KOMF_LOG_LEVEL=INFO
      - KOMF_SERVER_PORT=8089"                                 # Extra Payload to add to the Compose


# Execute
app